using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace tapetool2
{
    public class MovingAverage
    {
        public MovingAverage(int period)
        {
            Period = period;
        }

        public int Period
        {
            get
            {
                return _values.Capacity;
            }
            set
            {
                _values = new RingBuffer<double>(value);
                _total = 0;
            }
        }

        public void Add(double value)
        {
            if (_values.IsFull)
            {
                double oldVal;
                _values.Dequeue(out oldVal);
                _total -= oldVal;
            }

            _total += value;
            _values.Enqueue(value);
        }

        public double Value
        {
            get
            {
                if (_values.Count == 0)
                    return 0;

                return _total / _values.Count;
            }
        }

        RingBuffer<double> _values;
        double _total;
    }
}
