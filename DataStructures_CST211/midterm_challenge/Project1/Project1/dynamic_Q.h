//Cari Blaker
//Lab 4
//02/09/23

#pragma once
#include "Array.h"
#include "Exception.h"

template <typename T>
class Queue {
private:
	Array <T> m_queue;
	int m_size;									//this will be the current size of the Queue. The array class will keep track of the limit.
	int front, back;							//these will keep track of the front and back of our circle queue

public:
	Queue() : m_size{ 0 }, m_queue{ 10, 0 }, front{ -1 }, back{ -1 } { }		//default constructor creates an array of length 10, starting index 0
			
	Queue(int length) : m_queue{ length }, m_size{ 0 }, front{ -1 }, back{ -1 } {}

	Queue(const Queue& copy)					//copy constructor
	{
		m_size = copy.m_size;
		m_queue = copy.m_queue;
		front = copy.front;
		back = copy.back;
	}

	Queue(Queue&& move) noexcept				//move constructor
	{
		*this = move;
	}

	~Queue() { }								//destructor

	Queue& operator=(const Queue& copy)			//copy assignment operator
	{
		m_size = copy.m_size;
		m_queue = copy.m_queue;
		front = copy.front;
		back = copy.back;
		return *this;
	}

	Queue& operator=(Queue&& move) noexcept		//move assignment operator
	{
		*this = move;
		return *this;
	}

	void Enqueue(const T data)								//sets data at the back of the queue
	{
		if (isFull())
			throw Exception("Error: Queue is full");
		else if (isEmpty())
		{
			front = 0;
			back = 0;
			m_queue[back] = data;
		}
		else
		{
			if (back < m_queue.getLength())
				back++;
			else
				back = 0;

			m_queue[back] = data;
		}
		m_size++;
	}

	T Dequeue()														//takes the data off of the front of the queue
	{
		if (isEmpty())
			throw Exception("Error: The queue is empty");

		T element = m_queue[front];
		m_size--;

		if (front < m_queue.getLength())				//if we're still within the circle...
			front++;								//push the front out to accomodate the dequeue
		else
			front = 0;								//if we need to loop back around in the circle, put the front at 0 again

		if (isEmpty())											//unless it's now empty, then both back and front need to be at -1
		{
			front = -1;
			back = front;
		}
		return element;
	}

	T Peek()													//returns a copy of the front of the queue
	{
		if (isEmpty())
			throw Exception("Error: Queue is empty");
		return m_queue[front];
	}

	int getSize() const											//returns the current number of things? nodes? in the queue
	{
		return m_size;
	}

	bool isEmpty() const										//true if queue is empty
	{
		bool empty = false;
		if (m_size == 0)
			empty = true;

		return empty;
	}

	bool isFull() const											//true if queue is full
	{
		bool full = false;
		if (m_size >= m_queue.m_length)
			full = true;

		return full;
	}

	void Print()												//prints each item in queue on a new line (if there is anything in the queue)
	{
		if (isEmpty())
			throw Exception("Error: could not print, list is empty");

		if (front == back)
			cout << m_queue[front] << endl;

		else if (front < back)
		{
			for (int i = front; i != back; i++)
				cout << m_queue[i] << endl;
		}

		else if (front > back)
		{
			for (int i = front; i <= m_queue.getLength(); i++)
			{
				cout << m_queue[i] << endl;
			}

			for (int i = back; i < front; i++)
			{
				cout << m_queue[i] << endl;
			}
		}

	}

	int getFront()														//returns the index of the current front
	{
		return front;
	}

	int getBack()														//returns the index of the current back
	{
		return back;
	}

};
