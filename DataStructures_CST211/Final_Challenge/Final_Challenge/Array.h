//Cari Blaker
//Lab 4
//02/09/23
#ifndef ARRAYTEMPLATE_H
#define ARRAYTEMPLATE_H

#include <iostream>
#include <string>
#include "Exception.h"

using std::cout;
using std::cin;
using std::endl;
using std::string;

template <typename T>
class Array {
	template <typename U> friend class Queue;
private:
	T* m_array;
	int m_start_index;
	int m_length;

public:
	Array() : m_array(nullptr), m_start_index(0), m_length(0) {};	//default constructor
	Array(int length, int start_index = 0);							//constructor
	Array(const Array<T>& copy);									//copy constructor
	Array(Array<T>&& move) noexcept;								//move constructor

	~Array();														//destructor

	Array<T>& operator = (const Array<T>& copy);					//overloaded copy assignment operator 
	Array<T>& operator = (Array<T>&& move) noexcept;				//overloaded move assignment operator
	T& operator [] (const int);										//overloaded subscript operator

	const int getStartIndex();						//gets start index
	void setStartIndex(const int start_index);		//sets start index
	const int getLength();							//gets length of array
	void setLength(int length);						//sets length of array
};

template<typename T>								
Array<T>::Array(int length, int start_index) : m_start_index(0), m_length(0), m_array(nullptr)		//paramaterized constructor
{
	if (length < 0)
		throw Exception("Length must be > or = 0");

	m_length = length;
	m_array = new T[m_length];
	m_start_index = start_index;

}

template<typename T>
Array<T>::Array(const Array<T>& copy)										//copy constructor
{

	if (&copy != this)
	{
		delete[] m_array;
		m_array = nullptr; 
		m_array = new T[copy.m_length];
		m_length = copy.m_length;
		m_start_index = copy.m_start_index;
		for (int i = 0; i < m_length; i++)
		{
			m_array[i] = copy.m_array[i];
		}
	}
}

template<typename T>														//move constructor
Array<T>::Array(Array<T>&& move) noexcept
{
	*this = move;
}

template<typename T>
Array<T>::~Array()															//deconstructor
{
	if (m_array != nullptr)
	{
		delete[] m_array;
		m_array = nullptr;
	}
}

template<typename T>
Array<T>& Array<T>::operator = (const Array<T>& copy)									//copy assignment operator
{
	if (&copy != this)																	//avoid self-assignment
	{
		delete[] m_array;
		m_array = new T[copy.m_length];		
		m_length = copy.m_length;
		m_start_index = copy.m_start_index;

		for (int i = 0; i < m_length; i++)
		{
			m_array[i] = copy.m_array[i];
		}
	}

	return *this;
}

template<typename T>
Array<T>& Array<T>::operator = (Array<T>&& move) noexcept					//move assignment operator
{
	*this = move;
	return *this;
}

template<typename T>
T& Array<T>::operator [] (const int index)
{
	if ( index > (m_length + m_start_index)  || index < m_start_index )
		throw Exception("Index out of range");								//throw exception for out of bounds

	return m_array[index - m_start_index];									//returns copy of info at index
}

template<typename T>
const int Array<T>::getStartIndex()											//m_start_index getter
{
	return m_start_index;
}

template<typename T>
void Array<T>::setStartIndex(const int start_index)							//m_start_index setter
{
	m_start_index = start_index;
}

template<typename T>
const int Array<T>::getLength()												//m_length getter
{
	return m_length;
}

template<typename T>
void Array<T>::setLength(int length)										//m_length setter
{
	if (length >= 0)														//if the length doesn't change, none of this runs, so nothing changes.
	{
		T* temp = new T[length];											//allocate a new array to replace m_array
		
		int minLength = m_length < length ? m_length : length;
		for (int i = 0; i < minLength; i++)									//copy the values that already exist over
			temp[i] = m_array[i];

		delete[] m_array; 
		m_array = temp;
		m_length = length;
	}
	else
		throw Exception("Length must be > 0");								//throw exception for length <= 0
}

#endif //ARRAY_TEMPLATE_H

