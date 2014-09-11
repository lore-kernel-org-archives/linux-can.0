From: "Ruan TingQuan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>
Subject: Block application on CAN socket
Date: Thu, 11 Sep 2014 09:46:30 +0800
Message-ID: <1D8038C1668084449AECCE3515047A7F28C3EBFD78@SGPMBX01.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_1D8038C1668084449AECCE3515047A7F28C3EBFD78SGPMBX01APACb_"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:37414 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaIKBqp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 10 Sep 2014 21:46:45 -0400
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 8E198D8019D
	for <linux-can@vger.kernel.org>; Thu, 11 Sep 2014 03:46:42 +0200 (CEST)
Received: from localhost (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta13.fe.internet.bosch.com (Postfix) with SMTP id 99E196006D2
	for <linux-can@vger.kernel.org>; Thu, 11 Sep 2014 03:46:42 +0200 (CEST)
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

--_002_1D8038C1668084449AECCE3515047A7F28C3EBFD78SGPMBX01APACb_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Linux-can-team,

Several days ago, I got the solution of how to block application on CAN soc=
ket from document "SocketCAN and queueing disciplines:Final Report".
Here is the document link: http://rtime.felk.cvut.cz/can/socketcan-qdisc-fi=
nal.pdf
Reference to chapter "3.4. Blocking the application when the queue is full"=
:
	"Therefore, the solution is to set SO_SNDBUF low enough that this limit is=
 reached before tx queue len limit." ......
	"the minimum value causes the application to block when there are about 15=
 frames queued. If we want all CAN applications in the system to block inst=
ead
	of receiving ENOBUFS, it is necessary to set the txqueuelen (see Section 3=
.1.2) to the number of simultaneously used CAN sockets in the system multip=
lied by 15."

To verify this solution, a test program was made to send 64 frames to CAN s=
ocket. My test system : ubuntu 12.04 (kernel 3.11) + PEAK CAN controller (c=
an0)
CAN socket was created with block mode and SO_SNDBUF is 163840 bytes (defau=
lt setting). when continuously write more than 30 frames to CAN socket, App=
lication got error return -ENOBUFS. That is expected. But, if the SO_SNDBUF=
 was set to minimum value (4480 bytes), the application was blocked instead=
 of return -ENOBUFS. This is different with description in above doc.
According to the description on above solution, if SO_SNDBUF limits at 4480=
 bytes, about 22 frames make SO_SNDBUF full. and, tx queue len keeps in 10.=
 So, application should still get error return -ENOBUFS.  Why application w=
as blocked?

Attached file is my test program. The problem should be reproduced easily.
The print message from my test program are explained as below follow "//":
--------------------------------------------------
Default CAN socket send buffer size =3D 163840 (bytes)        // Default (o=
riginal) SO_SNDBUF value =3D 163840 bytes

****1**** Send 64 frames continuously to test block...	// Start the testing=
 original CAN socket (SO_SNDBUF=3D163840 bytes + tx queue=3D10)
-1- Write the 1th frame successfully.
-1- Write the 2th frame successfully.
-1- Write the 3th frame successfully.
-1- Write the 4th frame successfully.
-1- Write the 5th frame successfully.
-1- Write the 6th frame successfully.
-1- Write the 7th frame successfully.
-1- Write the 8th frame successfully.
-1- Write the 9th frame successfully.
-1- Write the 10th frame successfully.
-1- Write the 11th frame successfully.
-1- Write the 12th frame successfully.
-1- Write the 13th frame successfully.
-1- Write the 14th frame successfully.
-1- Write the 15th frame successfully.
-1- Write the 16th frame successfully.
-1- Write the 17th frame successfully.
-1- Write the 18th frame successfully.
-1- Write the 19th frame successfully.
-1- Write the 20th frame successfully.
-1- Write the 21th frame successfully.
-1- Write the 22th frame successfully.
-1- Write the 23th frame successfully.
-1- Write the 24th frame successfully.
-1- Write the 25th frame successfully.
-1- Write the 26th frame successfully.
-1- Write the 27th frame successfully.
-1- Write the 28th frame successfully.
-1- Write the 29th frame successfully.
-1- Write the 30th frame successfully.
-1- Write the 31th frame successfully.
-1- Write() return error :: No buffer space available	// function write() r=
eturn -ENOBUFS at the 31th frame sending

--------------------------------------------------
Set size of send buffer to minimum value =3D 4480 (bytes)	// Change SO_SNDB=
UF to minimum =3D 4480 (bytes)

****2**** Send 64 frames continuously to test block again...    // Start th=
e second testing on CAN socket (SO_SNDBUF=3D4480 bytes + tx queue=3D10)
-2- All frames were send successfully! that means blocking works.  // All f=
rames are send successfully without error return.

Regards!
Leo Ruan

--_002_1D8038C1668084449AECCE3515047A7F28C3EBFD78SGPMBX01APACb_
Content-Type: text/plain; name="BlockAppOnCANSocket.cpp"
Content-Description: BlockAppOnCANSocket.cpp
Content-Disposition: attachment; filename="BlockAppOnCANSocket.cpp";
	size=3271; creation-date="Wed, 10 Sep 2014 05:53:38 GMT";
	modification-date="Thu, 11 Sep 2014 01:08:37 GMT"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8ZXJybm8uaD4KCiNpbmNsdWRlIDxuZXQvaWYuaD4KI2luY2x1ZGUgPHN5cy9z
b2NrZXQuaD4KI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgojaW5jbHVkZSA8bGludXgvY2FuLmg+Cgpz
dGF0aWMgY29uc3QgY2hhciogQ0FOSUZOYW1lID0gImNhbjAiOwoKaW50IG1haW4odm9pZCkKewog
ICAgaW50IFNvY2tldGZkOwogICAgc3RydWN0IHNvY2thZGRyX2NhbiBhZGRyOwogICAgc3RydWN0
IGlmcmVxIGlmcjsKICAgIAogICAgLy8gT3BlbiBDQU4gc29ja2V0IHdpdGggYmxvY2tpbmcgbW9k
ZShkZWZhdWx0IHNldHRpbmcpCiAgICBpZigoU29ja2V0ZmQgPSBzb2NrZXQoUEZfQ0FOLCBTT0NL
X1JBVywgQ0FOX1JBVykpIDwgMCkKICAgIHsKICAgICAgICBwZXJyb3IoIkVycm9yIHdoaWxlIG9w
ZW5pbmcgc29ja2V0Iik7CiAgICAgICAgcmV0dXJuIC0xOwogICAgfQogICAgc3RyY3B5KGlmci5p
ZnJfbmFtZSwgQ0FOSUZOYW1lKTsKICAgIGlvY3RsKFNvY2tldGZkLCBTSU9DR0lGSU5ERVgsICZp
ZnIpOwoKICAgIGFkZHIuY2FuX2ZhbWlseSAgPSBBRl9DQU47CiAgICBhZGRyLmNhbl9pZmluZGV4
ID0gaWZyLmlmcl9pZmluZGV4OyAKCiAgICBpZihiaW5kKFNvY2tldGZkLCAoc3RydWN0IHNvY2th
ZGRyICopJmFkZHIsIHNpemVvZihhZGRyKSkgPCAwKSAKICAgIHsKICAgICAgICBwZXJyb3IoIkVy
cm9yIGluIHNvY2tldCBiaW5kIik7CiAgICAgICAgcmV0dXJuIC0xOwogICAgfQogICAgZWxzZQog
ICAgewogICAgICAgIHByaW50ZigiQ0FOIHNvY2tldCAlZCBiaW5kIGF0ICVzIChpbmRleCAlZClc
biIsIFNvY2tldGZkLCBDQU5JRk5hbWUsIGlmci5pZnJfaWZpbmRleCk7CiAgICB9CgogICAgLy8g
UHJpbnQgZGVmYXVsdCBzaXplIG9mIENBTiBzb2NrZXQgc2VuZCBidWZmZXIKICAgIGludCBCdWZm
ZXJTaXplID0gMDsKICAgIHVuc2lnbmVkIGludCBCdWZmZXJTaXplX2xlbiA9IDQ7CiAgICBnZXRz
b2Nrb3B0KFNvY2tldGZkLCBTT0xfU09DS0VULCBTT19TTkRCVUYsICh2b2lkICopJkJ1ZmZlclNp
emUsICZCdWZmZXJTaXplX2xlbik7CiAgICBwcmludGYoIi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXG4iKTsKICAgIHByaW50ZigiRGVmYXVsdCBDQU4g
c29ja2V0IHNlbmQgYnVmZmVyIHNpemUgPSAlZCAoYnl0ZXMpXG5cbiIsIEJ1ZmZlclNpemUpOwoK
ICAgIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKgogICAgVGVzdCBpZiBibG9jayBtb2RlIHdvcmtzIG9yIG5v
dAogICAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqLwogICAgc3RydWN0IGNhbl9mcmFtZSBmcmFtZTsKICAg
IGZyYW1lLmNhbl9pZCAgPSAweDEyMzsKICAgIGZyYW1lLmNhbl9kbGMgPSA4OwogICAgZnJhbWUu
ZGF0YVswXSA9IDB4NDE7CiAgICBmcmFtZS5kYXRhWzFdID0gMHg0MjsKICAgIGZyYW1lLmRhdGFb
Ml0gPSAweDQzOwogICAgZnJhbWUuZGF0YVszXSA9IDB4NDQ7IAogICAgZnJhbWUuZGF0YVs0XSA9
IDB4NDU7CiAgICBmcmFtZS5kYXRhWzVdID0gMHg0NjsKICAgIGZyYW1lLmRhdGFbNl0gPSAweDQ3
OwogICAgZnJhbWUuZGF0YVs3XSA9IDB4NDg7CiAgICAKICAgIHByaW50ZigiKioqKjEqKioqIFNl
bmQgNjQgZnJhbWVzIGNvbnRpbnVvdXNseSB0byB0ZXN0IGJsb2NrLi4uXG4iKTsKICAgIC8vIFNl
bmQgNjQgZnJhbWUgdG8gQ0FOIHNvY2tldCwgdGVzdCByZXR1cm4gdmFsdWUKICAgIGZvciAoaW50
IGNvdW50ID0gMDsgY291bnQgPCA2NDsgY291bnQrKykKICAgIHsKICAgICAgICBpbnQgbmJ5dGVz
ID0gd3JpdGUoU29ja2V0ZmQsICZmcmFtZSwgc2l6ZW9mKGZyYW1lKSk7CiAgICAgICAgaWYgKG5i
eXRlcyAhPSBzaXplb2Yoc3RydWN0IGNhbl9mcmFtZSkpCiAgICAgICAgewogICAgICAgICAgIHBl
cnJvcigiLTEtIFdyaXRlKCkgcmV0dXJuIGVycm9yIDoiKTsKICAgICAgICAgICBicmVhazsKICAg
ICAgICB9CiAgICAgICAgZWxzZQogICAgICAgIHsKICAgICAgICAgICAgcHJpbnRmKCItMS0gV3Jp
dGUgdGhlICVkdGggZnJhbWUgc3VjY2Vzc2Z1bGx5LlxuIiwgY291bnQrMSk7CiAgICAgICAgfQog
ICAgfQoKICAgIC8vIFNldCBzaXplIG9mIENBTiBzb2NrZXQgc2VuZCBidWZmZXIgdG8gbWluaW11
bQogICAgaW50IE5ld0J1ZmZlclNpemUgPSAwOwogICAgc2V0c29ja29wdChTb2NrZXRmZCwgU09M
X1NPQ0tFVCwgU09fU05EQlVGLCAodm9pZCAqKSZOZXdCdWZmZXJTaXplLCBzaXplb2YoTmV3QnVm
ZmVyU2l6ZSkpOwoKICAgIC8vIFByaW50IG1pbmltdW0gdmFsdWUgb2YgYnVmZmVyIHNpemUKICAg
IGdldHNvY2tvcHQoU29ja2V0ZmQsIFNPTF9TT0NLRVQsIFNPX1NOREJVRiwgKHZvaWQgKikmQnVm
ZmVyU2l6ZSwgJkJ1ZmZlclNpemVfbGVuKTsKICAgIHByaW50ZigiLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1cbiIpOwogICAgcHJpbnRmKCJTZXQgc2l6
ZSBvZiBzZW5kIGJ1ZmZlciB0byBtaW5pbXVtIHZhbHVlID0gJWQgKGJ5dGVzKVxuXG4iLCBCdWZm
ZXJTaXplKTsKICAgIAogICAgcHJpbnRmKCIqKioqMioqKiogU2VuZCA2NCBmcmFtZXMgY29udGlu
dW91c2x5IHRvIHRlc3QgYmxvY2sgYWdhaW4uLi5cbiIpOwogICAgYm9vbCBSZXRFcnIgPSBmYWxz
ZTsKICAgIGZvciAoaW50IGNvdW50ID0gMDsgY291bnQgPCA2NDsgY291bnQrKykKICAgIHsKICAg
ICAgIGludCBuYnl0ZXMgPSB3cml0ZShTb2NrZXRmZCwgJmZyYW1lLCBzaXplb2YoZnJhbWUpKTsK
ICAgICAgIGlmIChuYnl0ZXMgIT0gc2l6ZW9mKHN0cnVjdCBjYW5fZnJhbWUpKQogICAgICAgewog
ICAgICAgICAgcHJpbnRmKCItMi0gQ0FOIHNvY2tldCByZXR1cm4gZXJyb3IgYXQgdGhlICVkIGZy
YW1lIHdyaXRpbmciLCBjb3VudCk7CiAgICAgICAgICBwZXJyb3IoIjoiKTsKICAgICAgICAgIFJl
dEVyciA9IHRydWU7CiAgICAgICAgICBicmVhazsKICAgICAgIH0KICAgIH0KICAgIGlmIChSZXRF
cnIgPT0gZmFsc2UpCiAgICB7CiAgICAgICBwcmludGYoIi0yLSBBbGwgZnJhbWVzIHdlcmUgc2Vu
ZCBzdWNjZXNzZnVsbHkhIHRoYXQgbWVhbnMgYmxvY2tpbmcgd29ya3MuXG4iKTsKICAgIH0KCiAg
ICBjbG9zZShTb2NrZXRmZCk7Cn0KCg==

--_002_1D8038C1668084449AECCE3515047A7F28C3EBFD78SGPMBX01APACb_--

