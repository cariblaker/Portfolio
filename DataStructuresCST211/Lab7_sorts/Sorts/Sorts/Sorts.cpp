//Cari Blaker
//CST 211, Lab7
//Due 3/9/23

#include <iostream>
#include <fstream>
#include <chrono>
#include <random>
#include <algorithm>
#include <cstring>
#include "Array.h"
using namespace std;

// Swap function to swap two integers
void swap(int& a, int& b)
{
    int temp = a;
    a = b;
    b = temp;
}

// Brute Force Bubbles
void bruteForceBubbleSort(int arr[], int n)             //standard array
{
    for (int i = 0; i < n - 1; i++)                     //n is length of array
    {
        for (int j = 0; j < n - i - 1; j++)             //swap each as necessary until the last index not gone through
        {
            if (arr[j] > arr[j + 1])
            {
                swap(arr[j], arr[j + 1]);
            }
        }
    }
}

void bruteForceBubbleSort(vector<int> &arr, int n)               //vector
{
    for (int i = 0; i < n - 1; i++)                             //n is length of array
    {
        for (int j = 0; j < n - i - 1; j++)                     //swap each as necessary until the last index not gone through
        {
            if (arr[j] > arr[j + 1])
            {
                swap(arr[j], arr[j + 1]);
            }
        }
    }
}

void bruteForceBubbleSort(Array<int> &arr, int n)              //custom Array class
{
    for (int i = 0; i < n - 1; i++)                             //n is length of array
    {
        for (int j = 0; j < n - i - 1; j++)                     //swap each as necessary until the last index not gone through
        {
            if (arr[j] > arr[j + 1])
            {
                swap(arr[j], arr[j + 1]);
            }
        }
    }
}

// Flagged Bubble Sort
void flaggedBubbleSort(int arr[], int n)                //standard array
{
    bool swapped = true;                                //create a flag to signify swapped
    int i = 0;
    while (swapped)
    {
        swapped = false;
        for (int j = 0; j < n - i - 1; j++)             //until last index not gone through
        {
            if (arr[j] > arr[j + 1])
            {
                swap(arr[j], arr[j + 1]);
                swapped = true;
            }
        }
        i++;
    }
}

void flaggedBubbleSort(vector<int> &arr, int n)          //vector
{
    bool swapped = true;                                //create a flag to signify swapped
    int i = 0;
    while (swapped)
    {
        swapped = false;
        for (int j = 0; j < n - i - 1; j++)             //until last index not gone through
        {
            if (arr[j] > arr[j + 1])
            {
                swap(arr[j], arr[j + 1]);
                swapped = true;
            }
        }
        i++;
    }
}

void flaggedBubbleSort(Array<int> &arr, int n)          //custom Array class
{
    bool swapped = true;                                //create a flag to signify swapped
    int i = 0;
    while (swapped)
    {
        swapped = false;
        for (int j = 0; j < n - i - 1; j++)             //until last index not gone through
        {
            if (arr[j] > arr[j + 1])
            {
                swap(arr[j], arr[j + 1]);
                swapped = true;
            }
        }
        i++;
    }
}

// Selection sort
void selectionSort(int arr[], int n)                        //standard array
{
    for (int i = 0; i < n - 1; i++)                         //move boundary one by one
    {
        int min_index = i;
        for (int j = i + 1; j < n; j++)
        {
            if (arr[j] < arr[min_index])                    //find the index of the minimum
            {
                min_index = j;
            }
        }
        swap(arr[i], arr[min_index]);                       //swap the found element with the earliest element unsorted
    }
}

void selectionSort(vector<int> &arr, int n)                  //vector
{
    for (int i = 0; i < n - 1; i++)                         //move boundary one by one
    {
        int min_index = i;
        for (int j = i + 1; j < n; j++)
        {
            if (arr[j] < arr[min_index])                    //find the index of the minimum
            {
                min_index = j;
            }
        }
        swap(arr[i], arr[min_index]);                       //swap the found element with the earliest element unsorted
    }
}

void selectionSort(Array<int> &arr, int n)                   //custom array class
{
    for (int i = 0; i < n - 1; i++)                         //move boundary one by one
    {
        int min_index = i;
        for (int j = i + 1; j < n; j++)
        {
            if (arr[j] < arr[min_index])                    //find the index of the minimum
            {
                min_index = j;
            }
        }
        swap(arr[i], arr[min_index]);                       //swap the found element with the earliest element unsorted
    }
}

// Insertion sort
void insertionSort(int arr[], int n)
{
    for (int i = 1; i < n; i++)
    {
        int key = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j] > key)
        {
            arr[j + 1] = arr[j];                            //move elements greater than key to one position ahead of their current
            j--;
        }
        arr[j + 1] = key;                                   //place the key below all of those elements
    }
}

void insertionSort(vector<int> &arr, int n)                //vector
{
    for (int i = 1; i < n; i++)
    {
        int key = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j] > key)
        {
            arr[j + 1] = arr[j];                            //move elements greater than key to one position ahead of their current
            j--;
        }
        arr[j + 1] = key;                                   //place the key below all of those elements
    }
}

void insertionSort(Array<int> &arr, int n)                   //custom Array class
{
    for (int i = 1; i < n; i++)
    {
        int key = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j] > key)
        {
            arr[j + 1] = arr[j];                            //move elements greater than key to one position ahead of their current
            j--;
        }
        arr[j + 1] = key;                                   //place the key below all of those elements
    }
}

// Shell sort
void shellSort(int arr[], int n)
{
    for (int gap = n / 2; gap > 0; gap /= 2)                                //start with big gap, then smaller and smaller
    {
        for (int i = gap; i < n; i++)                                       //add one more element until full index reached
        {
            int temp = arr[i];                                              //store value of index i
            int j;                                                          
            for (j = i; j >= gap && arr[j - gap] > temp; j -= gap)          //shift previously sorted elements up until correct location value is found
            {
                arr[j] = arr[j - gap];
            }
            arr[j] = temp;                                                  //place value where it belongs
        }
    }
}

void shellSort(vector<int> &arr, int n)                                    //vector
{
    for (int gap = n / 2; gap > 0; gap /= 2)                                //start with big gap, then smaller and smaller
    {
        for (int i = gap; i < n; i++)                                       //add one more element until full index reached
        {
            int temp = arr[i];                                              //store value of index i
            int j;
            for (j = i; j >= gap && arr[j - gap] > temp; j -= gap)          //shift previously sorted elements up until correct location value is found
            {
                arr[j] = arr[j - gap];
            }
            arr[j] = temp;                                                  //place value where it belongs
        }
    }
}
   
void shellSort(Array<int> &arr, int n)                                            //custom Array Class
{
    for (int gap = n / 2; gap > 0; gap /= 2)                                //start with big gap, then smaller and smaller
    {
        for (int i = gap; i < n; i++)                                       //add one more element until full index reached
        {
            int temp = arr[i];                                              //store value of index i
            int j;
            for (j = i; j >= gap && arr[j - gap] > temp; j -= gap)          //shift previously sorted elements up until correct location value is found
            {
                arr[j] = arr[j - gap];
            }
            arr[j] = temp;                                                  //place value where it belongs
        }
    }
}

// Heap Sort & Helper function. Heapify a subtree rooted at index i.
void heapify(int arr[], int n, int i)       //standard array
{
    int largest = i;                        // Initialize largest as root
    int l = 2 * i + 1;                      // left child = 2*i + 1
    int r = 2 * i + 2;                      // right child = 2*i + 2

    // If left child is larger than root
    if (l < n && arr[l] > arr[largest])
        largest = l;

    // If right child is larger than largest so far
    if (r < n && arr[r] > arr[largest])
        largest = r;

    // If largest is not root
    if (largest != i)
    {
        swap(arr[i], arr[largest]);

        // Recursively heapify the affected sub-tree
        heapify(arr, n, largest);
    }
}

void heapSort(int arr[], int n)                                     //standard array
{
    // Build heap (rearrange array)
    for (int i = n / 2 - 1; i >= 0; i--)
        heapify(arr, n, i);

    // One by one extract an element from heap
    for (int i = n - 1; i > 0; i--)
    {
        // Move current root to end
        swap(arr[0], arr[i]);

        // call max heapify on the reduced heap
        heapify(arr, i, 0);
    }
}

void heapify(vector<int> &arr, int n, int i)
{
    int largest = i;                        // Initialize largest as root
    int l = 2 * i + 1;                      // left child = 2*i + 1
    int r = 2 * i + 2;                      // right child = 2*i + 2

    // If left child is larger than root
    if (l < n && arr[l] > arr[largest])
        largest = l;

    // If right child is larger than largest so far
    if (r < n && arr[r] > arr[largest])
        largest = r;

    // If largest is not root
    if (largest != i)
    {
        swap(arr[i], arr[largest]);

        // Recursively heapify the affected sub-tree
        heapify(arr, n, largest);
    }
}

void heapSort(vector<int> &arr, int n)
{
    // Build heap (rearrange array)
    for (int i = n / 2 - 1; i >= 0; i--)
        heapify(arr, n, i);

    // One by one extract an element from heap
    for (int i = n - 1; i > 0; i--)
    {
        // Move current root to end
        swap(arr[0], arr[i]);

        // call max heapify on the reduced heap
        heapify(arr, i, 0);
    }
}

void heapify(Array<int> &arr, int n, int i)
{
    int largest = i;                        // Initialize largest as root
    int l = 2 * i + 1;                      // left child = 2*i + 1
    int r = 2 * i + 2;                      // right child = 2*i + 2

    // If left child is larger than root
    if (l < n && arr[l] > arr[largest])
        largest = l;

    // If right child is larger than largest so far
    if (r < n && arr[r] > arr[largest])
        largest = r;

    // If largest is not root
    if (largest != i)
    {
        swap(arr[i], arr[largest]);

        // Recursively heapify the affected sub-tree
        heapify(arr, n, largest);
    }
}

void heapSort(Array<int> &arr, int n)
{
    // Build heap (rearrange array)
    for (int i = n / 2 - 1; i >= 0; i--)
        heapify(arr, n, i);

    // One by one extract an element from heap
    for (int i = n - 1; i > 0; i--)
    {
        // Move current root to end
        swap(arr[0], arr[i]);

        // call max heapify on the reduced heap
        heapify(arr, i, 0);
    }
}

// Merge sort (recursive)
void merge(int array[], int const left, int const mid, int const right)     //standard array

{
    auto const subArrayOne = mid - left + 1;
    auto const subArrayTwo = right - mid;

    // Create temp arrays
    auto* leftArray = new int[subArrayOne],
        * rightArray = new int[subArrayTwo];

    // Copy data to temp arrays leftArray[] and rightArray[]
    for (auto i = 0; i < subArrayOne; i++)
        leftArray[i] = array[left + i];
    for (auto j = 0; j < subArrayTwo; j++)
        rightArray[j] = array[mid + 1 + j];

    auto indexOfSubArrayOne = 0, // Initial index of first sub-array
        indexOfSubArrayTwo = 0; // Initial index of second sub-array
    int indexOfMergedArray = left; // Initial index of merged array

    // Merge the temp arrays back into array[left..right]
    while (indexOfSubArrayOne < subArrayOne && indexOfSubArrayTwo <
        subArrayTwo) {
        if (leftArray[indexOfSubArrayOne] <=
            rightArray[indexOfSubArrayTwo]) {
            array[indexOfMergedArray] = leftArray[indexOfSubArrayOne];
            indexOfSubArrayOne++;
        }
        else {
            array[indexOfMergedArray] =
                rightArray[indexOfSubArrayTwo];
            indexOfSubArrayTwo++;
        }
        indexOfMergedArray++;
    }
    // Copy the remaining elements of
    // left[], if there are any
    while (indexOfSubArrayOne < subArrayOne) {
        array[indexOfMergedArray] = leftArray[indexOfSubArrayOne];
        indexOfSubArrayOne++;
        indexOfMergedArray++;
    }
    // Copy the remaining elements of
    // right[], if there are any
    while (indexOfSubArrayTwo < subArrayTwo) {
        array[indexOfMergedArray] = rightArray[indexOfSubArrayTwo];
        indexOfSubArrayTwo++;
        indexOfMergedArray++;
    }
}

void mergeSort(int array[], int const begin, int const end)         //standard array
{
    if (begin >= end)
        return; // Returns recursively

    auto mid = begin + (end - begin) / 2;
    mergeSort(array, begin, mid);
    mergeSort(array, mid + 1, end);
    merge(array, begin, mid, end);
}

void merge(vector<int> &array, int const left, int const mid, int const right)     //vector

{
    auto const subArrayOne = mid - left + 1;
    auto const subArrayTwo = right - mid;

    // Create temp arrays
    auto* leftArray = new int[subArrayOne],
        * rightArray = new int[subArrayTwo];

    // Copy data to temp arrays leftArray[] and rightArray[]
    for (auto i = 0; i < subArrayOne; i++)
        leftArray[i] = array[left + i];
    for (auto j = 0; j < subArrayTwo; j++)
        rightArray[j] = array[mid + 1 + j];

    auto indexOfSubArrayOne = 0, // Initial index of first sub-array
        indexOfSubArrayTwo = 0; // Initial index of second sub-array
    int indexOfMergedArray = left; // Initial index of merged array

    // Merge the temp arrays back into array[left..right]
    while (indexOfSubArrayOne < subArrayOne && indexOfSubArrayTwo <
        subArrayTwo) {
        if (leftArray[indexOfSubArrayOne] <=
            rightArray[indexOfSubArrayTwo]) {
            array[indexOfMergedArray] = leftArray[indexOfSubArrayOne];
            indexOfSubArrayOne++;
        }
        else {
            array[indexOfMergedArray] =
                rightArray[indexOfSubArrayTwo];
            indexOfSubArrayTwo++;
        }
        indexOfMergedArray++;
    }
    // Copy the remaining elements of
    // left[], if there are any
    while (indexOfSubArrayOne < subArrayOne) {
        array[indexOfMergedArray] = leftArray[indexOfSubArrayOne];
        indexOfSubArrayOne++;
        indexOfMergedArray++;
    }
    // Copy the remaining elements of
    // right[], if there are any
    while (indexOfSubArrayTwo < subArrayTwo) {
        array[indexOfMergedArray] = rightArray[indexOfSubArrayTwo];
        indexOfSubArrayTwo++;
        indexOfMergedArray++;
    }
}

void mergeSort(vector<int> &array, int const begin, int const end)         //vector
{
    if (begin >= end)
        return; // Returns recursively

    auto mid = begin + (end - begin) / 2;
    mergeSort(array, begin, mid);
    mergeSort(array, mid + 1, end);
    merge(array, begin, mid, end);
}

void merge(Array<int> &array, int const left, int const mid, int const right)     //standard array

{
    auto const subArrayOne = mid - left + 1;
    auto const subArrayTwo = right - mid;

    // Create temp arrays
    auto* leftArray = new int[subArrayOne],
        * rightArray = new int[subArrayTwo];

    // Copy data to temp arrays leftArray[] and rightArray[]
    for (auto i = 0; i < subArrayOne; i++)
        leftArray[i] = array[left + i];
    for (auto j = 0; j < subArrayTwo; j++)
        rightArray[j] = array[mid + 1 + j];

    auto indexOfSubArrayOne = 0, // Initial index of first sub-array
        indexOfSubArrayTwo = 0; // Initial index of second sub-array
    int indexOfMergedArray = left; // Initial index of merged array

    // Merge the temp arrays back into array[left..right]
    while (indexOfSubArrayOne < subArrayOne && indexOfSubArrayTwo <
        subArrayTwo) {
        if (leftArray[indexOfSubArrayOne] <=
            rightArray[indexOfSubArrayTwo]) {
            array[indexOfMergedArray] = leftArray[indexOfSubArrayOne];
            indexOfSubArrayOne++;
        }
        else {
            array[indexOfMergedArray] =
                rightArray[indexOfSubArrayTwo];
            indexOfSubArrayTwo++;
        }
        indexOfMergedArray++;
    }
    // Copy the remaining elements of
    // left[], if there are any
    while (indexOfSubArrayOne < subArrayOne) {
        array[indexOfMergedArray] = leftArray[indexOfSubArrayOne];
        indexOfSubArrayOne++;
        indexOfMergedArray++;
    }
    // Copy the remaining elements of
    // right[], if there are any
    while (indexOfSubArrayTwo < subArrayTwo) {
        array[indexOfMergedArray] = rightArray[indexOfSubArrayTwo];
        indexOfSubArrayTwo++;
        indexOfMergedArray++;
    }
}

void mergeSort(Array<int> &array, int const begin, int const end)         //custom Array class
{
    if (begin >= end)
        return; // Returns recursively

    auto mid = begin + (end - begin) / 2;
    mergeSort(array, begin, mid);
    mergeSort(array, mid + 1, end);
    merge(array, begin, mid, end);
}

// Quick sort (recursive)
int partition(int arr[], int low, int high)                 
{
    int pivot = arr[high];
    int i = low - 1;
    for (int j = low; j <= high - 1; j++)
    {
        if (arr[j] < pivot)
        {
            i++;
            std::swap(arr[i], arr[j]);
        }
    }
    std::swap(arr[i + 1], arr[high]);
    return i + 1;
}

int partition(vector<int> &arr, int low, int high)
{
    int pivot = arr[high];
    int i = low - 1;
    for (int j = low; j <= high - 1; j++)
    {
        if (arr[j] < pivot)
        {
            i++;
            std::swap(arr[i], arr[j]);
        }
    }
    std::swap(arr[i + 1], arr[high]);
    return i + 1;
}

int partition(Array<int> &arr, int low, int high)
{
    int pivot = arr[high];
    int i = low - 1;
    for (int j = low; j <= high - 1; j++)
    {
        if (arr[j] < pivot)
        {
            i++;
            std::swap(arr[i], arr[j]);
        }
    }
    std::swap(arr[i + 1], arr[high]);
    return i + 1;
}

//
//void quickSort(int arr[], int low, int high)               //this function does not work with standard array class.
//{                                                             //causes stack overflow.
//    if (low < high)
//    {
//        int pi = partition(arr, low, high);                //partitioning index now at its correct place
//        quickSort(arr, low, pi - 1);                        //sort before partition
//        quickSort(arr, pi + 1, high);                       //sort after partition
//    }
//}

void quickSort(int arr[], int low, int high)                //for whatever reason, I had to rework this function for the
{                                                           //standard array class, even though the other code works for the other types of data...
    int* stack = new int[high - low + 1];
    int top = -1;

    stack[++top] = low;
    stack[++top] = high;

    while (top >= 0) {
        high = stack[top--];
        low = stack[top--];

        int p = partition(arr, low, high);

        if (p - 1 > low) {
            stack[++top] = low;
            stack[++top] = p - 1;
        }

        if (p + 1 < high) {
            stack[++top] = p + 1;
            stack[++top] = high;
        }
    }

    delete [] stack;
}

void quickSort(vector<int> &arr, int low, int high)
{
    if (low < high)
    {
        int pi = partition(arr, low, high);                //partitioning index now at its correct place
        quickSort(arr, low, pi - 1);                        //sort before partition
        quickSort(arr, pi + 1, high);                       //sort after partition
    }
}

void quickSort(Array<int> &arr, int low, int high)
{
    if (low < high)
    {
        int pi = partition(arr, low, high);                //partitioning index now at its correct place
        quickSort(arr, low, pi - 1);                        //sort before partition
        quickSort(arr, pi + 1, high);                       //sort after partition
    }
}



//these functions send the different buckets/bags to the respective sorting functions & output to file
void bubbSort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile);
void fBubbSort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile);
void selectSort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile);
void insertSort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile);
void ShellySort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile);
void HeapySort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile);
void MergeSort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile);
void QuickSort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile);


int main(int argc, char* argv[]) {
    // Check if the number of records to sort was passed as a command line argument
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " num_records\n";
        return 1;
    }

    // Parse the number of records to sort from the command line argument
    int num_records = std::stoi(argv[1]);
    std::cout << "Sorting " << num_records << " records\n";

    // Create and randomly fill an array with at least 10,000 integers
    vector<int> original(num_records);
    random_device rd;
    mt19937 gen(rd());
    uniform_int_distribution<int> dis(1, num_records);
    generate(original.begin(), original.end(), [&dis, &gen]() { return dis(gen); });

    // Use C-Arrays (native arrays), vector class, and Array class from Lab1 as containers
    int* arr1 = new int[num_records];                               //native arrays
    for (int i = 0; i < num_records; i++) {
        arr1[i] = original[i];
    }

    vector<int> arr2(original);                                     //vector array

    Array<int> arr3(num_records);                                   //custom array class
    for (int i = 0; i < num_records; i++) {
        arr3[i] = original[i];
    }

    Array<int> OG_3 = arr3;                                          //make a copies of the original to be reset later
    vector<int> OG_2(arr2);
    int* OG_1(arr1);

    // Create an output file to write the results
    std::ofstream outfile("output.txt");

    // Brute force bubble sort for the three types
    bubbSort(arr1, arr2, arr3, num_records, outfile);

    arr1 = OG_1;                                                    //reset for next sort
    arr2 = OG_2;
    arr3 = OG_3;

    // Flagged bubble sort
    fBubbSort(arr1, arr2, arr3, num_records, outfile);

    arr1 = OG_1;                                                    //reset for next sort
    arr2 = OG_2;
    arr3 = OG_3;

    // Selection sort
    selectSort(arr1, arr2, arr3, num_records, outfile);

    arr1 = OG_1;                                                    //reset for next sort
    arr2 = OG_2;
    arr3 = OG_3;

    // Insertion sort
    insertSort(arr1, arr2, arr3, num_records, outfile);

    arr1 = OG_1;                                                    //reset for next sort
    arr2 = OG_2;
    arr3 = OG_3;

    // Shell sort
    ShellySort(arr1, arr2, arr3, num_records, outfile);

    arr1 = OG_1;                                                    //reset for next sort
    arr2 = OG_2;
    arr3 = OG_3;

    // Heap sort
    HeapySort(arr1, arr2, arr3, num_records, outfile);

    arr1 = OG_1;                                                    //reset for next sort
    arr2 = OG_2;
    arr3 = OG_3;

    // Merge sort
    MergeSort(arr1, arr2, arr3, num_records, outfile);

    arr1 = OG_1;                                                    //reset for next sort
    arr2 = OG_2;
    arr3 = OG_3;

    // Quick sort
    QuickSort(arr1, arr2, arr3, num_records, outfile);

    //outFile.close();

    return 0;
}



// Brute force bubble sort sender
void bubbSort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile) {

    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    bruteForceBubbleSort(arr1, num_records);
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    std::cout << "Brute force bubble sort w/ standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Brute force bubble sort w/ standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds.\n Last value: " << arr1[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    bruteForceBubbleSort(arr2, num_records);
    end = std::chrono::steady_clock::now();
    std::cout << "Brute force bubble sort w/ standard vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Brute force bubble sort w/ standard vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr2[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    bruteForceBubbleSort(arr3, num_records);
    end = std::chrono::steady_clock::now();
    std::cout << "Brute force bubble sort w/ standard vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Brute force bubble sort w/ standard vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr3[num_records - 1] << "\n";
}

//flagged bubble sort sender
void fBubbSort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile) {

    //standard array
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    flaggedBubbleSort(arr1, num_records);
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    std::cout << "Flagged bubble sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Flagged bubble sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr1[num_records - 1] << "\n";

    //vector
    begin = std::chrono::steady_clock::now();
    flaggedBubbleSort(arr2, num_records);
    end = std::chrono::steady_clock::now();
    std::cout << "Flagged bubble sort vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Flagged bubble sort vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr2[num_records - 1] << "\n";

    //custom array class
    begin = std::chrono::steady_clock::now();
    flaggedBubbleSort(arr3, num_records);
    end = std::chrono::steady_clock::now();
    std::cout << "Flagged bubble sort custom Array class: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Flagged bubble sort custom Array class: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n: Last Value: " << arr3[num_records - 1] << "\n";

}

//selection sort sender
void selectSort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile) {
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    selectionSort(arr1, num_records);
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    std::cout << "Selection sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Selection sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr1[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    selectionSort(arr2, num_records);
    end = std::chrono::steady_clock::now();
    std::cout << "Selection sort vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Selection sort vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr2[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    selectionSort(arr3, num_records);
    end = std::chrono::steady_clock::now();
    std::cout << "Selection sort custom Array class: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Selection sort custom Array class: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr3[num_records - 1] << "\n";
}

//insertion sort sender
void insertSort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile) {
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    insertionSort(arr1, num_records);
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    std::cout << "Insertion sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Insertion sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n Last value: " << arr1[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    insertionSort(arr2, num_records);
    end = std::chrono::steady_clock::now();
    std::cout << "Insertion sort vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Insertion sort vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr2[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    insertionSort(arr3, num_records);
    end = std::chrono::steady_clock::now();
    std::cout << "Insertion sort custom Array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Insertion sort custom Array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr3[num_records - 1] << "\n";
}

//shell sort sender
void ShellySort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile) {
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    shellSort(arr1, num_records);
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    std::cout << "Shell sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Shell sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr1[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    shellSort(arr2, num_records);
    end = std::chrono::steady_clock::now();
    std::cout << "Shell sort vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Shell sort vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr2[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    shellSort(arr3, num_records);
    end = std::chrono::steady_clock::now();
    std::cout << "Shell sort custom Array class: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Shell sort custom Array class: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr3[num_records - 1] << "\n";
}

//heap sort sender
void HeapySort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile) {
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    heapSort(arr1, num_records);
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    std::cout << "Heap sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Heap sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr1[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    heapSort(arr2, num_records);
    end = std::chrono::steady_clock::now();
    std::cout << "Heap sort vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Heap sort vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr2[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    heapSort(arr1, num_records);
    end = std::chrono::steady_clock::now();
    std::cout << "Heap sort custom Array class: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Heap sort custom Array class: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr3[num_records - 1] << "\n";
}

//merge sort sender
void MergeSort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile) {
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    mergeSort(arr1, 0, num_records - 1);
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    std::cout << "Merge sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Merge sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr1[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    mergeSort(arr2, 0, num_records - 1);
    end = std::chrono::steady_clock::now();
    std::cout << "Merge sort vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Merge sort vector: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr2[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    mergeSort(arr3, 0, num_records - 1);
    end = std::chrono::steady_clock::now();
    std::cout << "Merge sort custom Array class: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Merge sort custom Array class: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr3[num_records - 1] << "\n";
}


void QuickSort(int arr1[], vector<int> arr2, Array<int> arr3, int num_records, ofstream& outfile) {
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    quickSort(arr1, 0, num_records - 1);
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    std::cout << "Quick sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Quick sort standard array: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr1[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    quickSort(arr2, 0, num_records - 1);
    end = std::chrono::steady_clock::now();
    std::cout << "Quick sort vector : " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Quick sort vector : " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr2[num_records - 1] << "\n";

    begin = std::chrono::steady_clock::now();
    quickSort(arr3, 0, num_records - 1);
    end = std::chrono::steady_clock::now();
    std::cout << "Quick sort custom Array class: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\n";
    outfile << "Quick sort custom Array class: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds\nLast value: " << arr3[num_records - 1] << "\n";
}
