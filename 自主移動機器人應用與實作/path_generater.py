#!/usr/bin/env python
# coding=utf-8

# Import necessary modules for ROS 2 communication
import os  # Operating system module
import select  # I/O multiplexing module
import sys  # System-specific parameters and functions module
import rclpy  # ROS 2 client library

# Import message types and Quality of Service (QoS) profile for ROS 2
from geometry_msgs.msg import PoseStamped
from rclpy.qos import QoSProfile  # Quality of Service profile for ROS 2

# Import modules for controlling terminal I/O settings
import tty  # Terminal control module



def main():
    """
    Main function to initialize ROS 2, create a node, and publish Twist messages.

    Explanation:
        - rclpy.init(): Initialize the ROS 2 client library.
        - qos = QoSProfile(depth=10): Define a Quality of Service profile with a queue depth of 10.
          This controls how messages are queued in the system.
        - node = rclpy.create_node('AMR_path'): Create a ROS 2 node with the name 'AMR_path'.
          A node is a process that performs computation.
        - pub = node.create_publisher(PoseStamped, '/goal_pose', qos): Create a publisher that publishes
          messages of type Twist to the topic '/goal_pose'. The publisher will use the specified QoS profile.

    Returns:
        None
    """
    
    
    rclpy.init()
    qos = QoSProfile(depth=10)
    node = rclpy.create_node('AMR_path')
    pub = node.create_publisher(PoseStamped, '/goal_pose', qos)
    
    try:
        goal_msg=PoseStamped()
        goal_msg.header.frame_id='map'
        goal_msg.pose.position.x=0.0
        goal_msg.pose.position.y=0.0
        goal_msg.pose.position.z=0.0
        goal_msg.pose.orientation.x=0.0
        goal_msg.pose.orientation.y=0.0
        goal_msg.pose.orientation.z=0.0
        goal_msg.pose.orientation.w=1.0
        pub.publish(goal_msg)
            
    except Exception as e:
        print('error!!')
        
        
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
