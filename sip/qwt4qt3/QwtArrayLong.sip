// The SIP interface specification for:
//      QwtArrayLong.
//
// Copyright (C) 2001-2008 Gerard Vermeulen
// Copyright (C) 2000 Mark Colclough
//
// This file is part of PyQwt.
//
// PyQwt is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// PyQwt is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along
// with PyQwt; if not, write to the Free Software Foundation, Inc.,
// 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
// In addition, as a special exception, Gerard Vermeulen gives permission
// to link PyQwt dynamically with non-free versions of Qt and PyQt,
// and to distribute PyQwt in this form, provided that equally powerful
// versions of Qt and PyQt have been released under the terms of the GNU
// General Public License.
//
// If PyQwt is dynamically linked with non-free versions of Qt and PyQt,
// PyQwt becomes a free plug-in for a non-free program.


class QwtArrayLong
{

%TypeHeaderCode
#include <qwt_array.h>
typedef QwtArray<long> QwtArrayLong;
%End // %TypeHeaderCode

public:
    QwtArrayLong();
    QwtArrayLong(int);
    QwtArrayLong(const QwtArrayLong &);
    QwtArrayLong(SIP_PYOBJECT); 
%MethodCode
    QwtArray<long> array;
    // Numeric is not thread-safe
    if (-1 == try_PyObject_to_QwtArray(a0, array))
        return 0;

    sipCpp = new QwtArrayLong(array);
%End // QwtArrayLong()
    ~QwtArrayLong(); 
    // not possible: QwtArray<type> &operator=(const QArray<type> &); 
    // not Pythonic: type *data() const;
    // not Pythonic: uint nrefs() const; 
    uint size() const;
    uint count() const;
    bool isEmpty() const;
    bool isNull() const;
    bool resize(uint);
    bool truncate(uint);
    bool fill(const long, int = -1);
    void detach();
    QwtArrayLong copy() const;
    QwtArrayLong & assign(const QwtArrayLong &);
    // not Pythonic: QwtArray<type> & assign(const type *, uint); 
    QwtArrayLong & duplicate(const QwtArrayLong &);
    // not Pythonic: QwtArray<type> & duplicate(const type *, uint); 
    // not Pythonic: QwtArray<type> & setRawData(const type *, uint);
    // not Pythonic: void resetRawData(const type *, uint);
    int find(const long &, uint = 0) const;
    int contains(const long &) const;
    void sort();
    int bsearch(const long &) const;
    // see __getitem__: type & operator[](int) const;
    long /* & */ at(uint) const;
    // pulls in unwanted operators: bool operator==(const QwtArrayLong &) const;
    // pulls in unwanted operators: bool operator!=(const QwtArrayLong &) const;
    // No iterators, yet: Iterator begin();
    // No iterators, yet: Iterator end();
    // No iterators, yet: ConstIterator begin() const;
    // No iterators, yet: ConstIterator end() const;

    long __getitem__(int);
%MethodCode
    int len = sipCpp -> size();
    
    if (0 > (a0 = sipConvertFromSequenceIndex(a0, len)))
        sipIsErr = 1;
    else
        sipRes = (*sipCpp)[a0];
%End // __getitem__()

    int __len__() const;
%MethodCode
    sipRes = sipCpp -> size();
%End // __len__()

    void __setitem__(int, long);
%MethodCode
    int len = sipCpp -> size();

    if (0 > (a0 = sipConvertFromSequenceIndex(a0, len)))
        sipIsErr = 1;
    else
        (*sipCpp)[a0] = a1;
%End // __setitem__()

    void __setitem__(SIP_PYSLICE, const QwtArrayLong &);
%MethodCode
    int len = sipCpp -> size();
    Py_ssize_t start, stop, step, slicelength;

    if (0 > sipConvertFromSliceObject(a0, len,
                                      &start, &stop, &step, &slicelength))
        sipIsErr = 1;
    else {
        int vlen = a1 -> size();

        if (vlen != slicelength) {
            sipBadLengthForSlice(vlen, slicelength);
            sipIsErr = 1;
        } else {
            QwtArrayLong::ConstIterator it = a1 -> begin();

            for (int i = 0; i < slicelength; ++i) {
                (*sipCpp)[int(start)] = *it;
                start += step;
                ++it;
            }
        }
    }
%End // __setitem__()

}; // class QwtArrayLong

// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:

