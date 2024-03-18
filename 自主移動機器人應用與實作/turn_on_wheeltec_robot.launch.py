import os  # Importing the os module for operating system functions
from pathlib import Path  # Importing the Path class from the pathlib module
import launch  # Importing the launch module for launching ROS 2 nodes
from launch.actions import SetEnvironmentVariable  # Importing SetEnvironmentVariable action for setting environment variables
from ament_index_python.packages import get_package_share_directory  # Importing get_package_share_directory function from ament_index_python.packages module
from launch import LaunchDescription  # Importing LaunchDescription class for defining launch descriptions
from launch.actions import (DeclareLaunchArgument, GroupAction,  # Importing action classes for defining launch actions
                            IncludeLaunchDescription, SetEnvironmentVariable)
from launch.launch_description_sources import PythonLaunchDescriptionSource  # Importing PythonLaunchDescriptionSource for launching Python-based launch descriptions
from launch.substitutions import LaunchConfiguration, PythonExpression  # Importing LaunchConfiguration and PythonExpression for defining launch substitutions
from launch_ros.actions import PushRosNamespace  # Importing PushRosNamespace action for pushing ROS namespaces
import launch_ros.actions  # Importing launch_ros.actions module for ROS-specific launch actions
from launch.conditions import UnlessCondition  # Importing UnlessCondition for defining launch conditions



def generate_launch_description():
    # Get the launch directory
    bringup_dir = get_package_share_directory('turn_on_wheeltec_robot')
    launch_dir = os.path.join(bringup_dir, 'launch')
    ekf_config = Path(get_package_share_directory('turn_on_wheeltec_robot'), 'config', 'ekf.yaml')

    
    carto_slam = LaunchConfiguration('carto_slam', default='false')
    carto_slam_dec = DeclareLaunchArgument('carto_slam',default_value='false')
            
    wheeltec_robot = IncludeLaunchDescription(
            PythonLaunchDescriptionSource(os.path.join(launch_dir, 'base_serial.launch.py')),
            launch_arguments={'akmcar': 'false'}.items(),
    )
    #choose your car,the default car is mini_mec 
    choose_car = IncludeLaunchDescription(
            PythonLaunchDescriptionSource(os.path.join(launch_dir, 'robot_mode_description.launch.py')),
    )

    
    base_to_link = launch_ros.actions.Node(
            package='tf2_ros', # Use functionality from the tf2_ros package
            executable='static_transform_publisher', # Execute the static_transform_publisher executable
            name='base_to_link', # Node name is base_to_gyro
            arguments=['0', '0', '0','0', '0','0','base_footprint','base_link'], # List of arguments for publishing the transform
    )
    base_to_gyro = launch_ros.actions.Node(
            package='tf2_ros', 
            executable='static_transform_publisher', 
            name='base_to_gyro',
            arguments=['0', '0', '0','0', '0','0','base_footprint','gyro_link'],
    )

    robot_ekf = launch_ros.actions.Node(
            condition=UnlessCondition(carto_slam),
            package='robot_localization', 
            executable='ekf_node', 
            parameters=[ekf_config], # Pass the configuration file as parameters to the node
            remappings=[("odometry/filtered", "odom_combined")]
            )
                              
    joint_state_publisher_node = launch_ros.actions.Node(
            package='joint_state_publisher', 
            executable='joint_state_publisher', 
            name='joint_state_publisher',
    )

    ld = LaunchDescription()  # Create a LaunchDescription object to define the launch configuration.

    ld.add_action(carto_slam_dec)
    ld.add_action(wheeltec_robot)
    ld.add_action(base_to_link)
    ld.add_action(base_to_gyro)
    ld.add_action(joint_state_publisher_node)
    ld.add_action(choose_car)
    ld.add_action(robot_ekf)

    return ld

