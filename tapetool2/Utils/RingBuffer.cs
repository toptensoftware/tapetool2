using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace tapetool2
{
    public class RingBuffer<T>
    {
        public RingBuffer(int capacity)
        {
            Reset(capacity);
        }

        public void Reset(int capacity)
        {
            _elems = new T[capacity+1];
            _readPos = 0;
            _writePos = 0;
        }

        public void Reset()
        {
            Reset(_elems.Length - 1);
        }

        public bool Enqueue(T t)
        {
            int nextWritePos = (_writePos + 1) % _elems.Length;
            if (nextWritePos == _readPos)
                return false;

            _elems[_writePos] = t;
            _writePos = nextWritePos;
            return true;
        }

        public bool Dequeue(out T t)
        {
            if (_readPos == _writePos)
            {
                t = default(T);
                return false;
            }

            t = _elems[_readPos];
            _readPos = (_readPos + 1) % _elems.Length;
            return true;
        }

        public int Count
        {
            get
            {
                int val = _writePos - _readPos;
                if (val < 0)
                    val += _elems.Length;
                return val;
            }
        }

        public bool IsFull
        {
            get { return (_writePos + 1) % _elems.Length == _readPos; }
        }

        public bool IsEmpty
        {
            get { return _readPos == _writePos; }
        }

        public int Capacity
        {
            get { return _elems.Length - 1; }
        }

        public T this[int index]
        {
            get
            {
                return GetAt(index);
            }
        }

        T GetAt(int index)
        {
            if (index < 0 || index >= Count)
                throw new ArgumentException();

            return _elems[(_readPos + index) % _elems.Length];
        }


        T[] _elems;
        int _readPos;
        int _writePos;
    }
}
