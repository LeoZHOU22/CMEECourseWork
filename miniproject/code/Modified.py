import pandas as pd

def load_and_prepare_data(data_file_path):
    # Load the data
    data_df = pd.read_csv("../data/LogisticGrowthData.csv")

    # Check for and handle missing data
    # Option 1: Remove rows with any missing values
    data_df = data_df.dropna()


    # Create unique identifier if not already present
    if 'UniqueGrowthCurveID' not in data_df.columns:
        data_df['UniqueGrowthCurveID'] = (
            data_df['Temp'].astype(str) + '-' +
            data_df['Species'] + '-' +
            data_df['Medium'] + '-' +
            data_df['Citation'] + '-' +
            data_df['Rep'].astype(str)
        )

    return data_df

def save_data(data_df, output_file_path):
    # Save the modified data to a CSV file
    data_df.to_csv("../data/ModifiedLogisticGrowthData.csv", index=False)

# Path to the dataset
data_file_path = "../data/LogisticGrowthData.csv"

# Prepare the data
prepared_data_df = load_and_prepare_data(data_file_path)

# Save the prepared data
output_file_path = "../data/ModifiedLogisticGrowthData.csv"
save_data(prepared_data_df, output_file_path)
