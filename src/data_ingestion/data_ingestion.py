import subprocess
import sys
import os
from pyspark.sql import SparkSession

os.chdir('..')



def load_csv_to_hadoop(local_file, hdfs_destination):
    """
    Loads a CSV file from the local file system to Hadoop HDFS using the 'hadoop fs -put' command.
    
    :param local_file: Path to the local CSV file.
    :param hdfs_destination: Destination path in HDFS (directory or full file path).
    """
    command = ['hadoop', 'fs', '-put', local_file, hdfs_destination]
    try:
        print(f"Uploading {local_file} to HDFS at {hdfs_destination}...")
        subprocess.run(command, check=True, shell = True)
        print("File successfully loaded into Hadoop HDFS!")
    except subprocess.CalledProcessError as e:
        print(f"Error uploading file: {e}")
        sys.exit(1)

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python load_csv_to_hadoop.py <local_csv_file> <hdfs_destination>")
        sys.exit(1)
    
    local_csv_file = sys.argv[1]
    hdfs_destination = sys.argv[2]
    
    load_csv_to_hadoop(local_csv_file, hdfs_destination)



def read_csv_data_from_hadoop(hadoop_data_directory):
    spark = SparkSession.builder.appName("data_preprocessing").getOrCreate()
    data = spark.read.csv(hadoop_data_directory, header=True, inferSchema=True)
    return data


