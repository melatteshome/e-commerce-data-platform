import numpy as np
from scipy import stats
import matplotlib.pyplot as plt


def  is_missing_value(df):
    """
    Check if there are missing values in the dataframe
    """
    return df.isnull().values.any()


def count_missing_values_per_column(df):
    """
    Count missing values per column
    """
    return df.isnull().sum()


def remove_missing_values(df):
    """
    Remove rows with missing values
    """
    return df.dropna()

def fill_missing_values(df, value):
    """
    Fill missing values with a specific value
    """
    return df.fillna(value)

def fill_missing_values_with_mean(df):
    """
    Fill missing values with the mean of the column
    """
    return df.fillna(df.mean())

def fill_missing_values_with_median(df):
    """
    Fill missing values with the median of the column
    """
    return df.fillna(df.median())



def fill_missing_values_with_mode(df):
    """
    Fill missing values with the mode of the column
    """
    return df.fillna(df.mode().iloc[0])


def fill_missing_values_with_interpolation(df):
    """
    Fill missing values with interpolation
    """
    return df.interpolate()


def remove_outliers(df, column, threshold=3):
    """
    Remove outliers from a column
    """
    z_scores = np.abs(stats.zscore(df[column]))
    return df[(z_scores < threshold)]


def find_outliers_IQR(df, column):

   q1=df[column].quantile(0.25)

   q3=df[column].quantile(0.75)

   IQR=q3-q1

   outliers = df[((df[column]<(q1-1.5*IQR)) | (df[column]>(q3+1.5*IQR)))]

   return outliers


def find_outlier_box_plot(df, column, threshold=3):
    """
    Detect outliers in a column
    """
    plt.figure(figsize=(8, 6))
    plt.boxplot(df[column], vert=True, patch_artist=True)
    plt.title('Box Plot of Age')
    plt.ylabel('Age (years)')
    plt.xlabel('Age Distribution')
    plt.show()
 