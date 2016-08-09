From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: SocketCAN device enumeration API
Date: Tue, 9 Aug 2016 13:06:39 +0200
Message-ID: <201d5fca-9ea8-aa0e-843e-f21441cd7170@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:58772 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873AbcHILHV (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 9 Aug 2016 07:07:21 -0400
Received: from [192.168.0.24] ([217.235.230.15]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0Lx4dh-1b8TUU3ZIf-016cXv for
 <linux-can@vger.kernel.org>; Tue, 09 Aug 2016 13:06:39 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello all,

I'm one of the developers working on the new QtSerialBus module [0], [1]
which encapsulates different CAN hardware drivers (including SocketCAN) 
in a C++ API.

For a new hardware enumerating function, I'd like to do the following:

* Enumerate the currently available (i.e. ready to use)
   SocketCAN devices
* Get hardware information/manufacturer/bus type for a device
* Find out if a device is virtual
* Find out if a device is CAN FD capable

Is there already a possibility to do this from a C/C++ program?
Some information can be parsed from the ip command output, but I'd 
rather use a real API.

If not already possible, could such functionality be added to SocketCAN?

Thanks in advance!

Best regards,
Andre

[0] http://doc.qt.io/qt-5/qtserialbus-index.html
[1] https://code.qt.io/qt/qtserialbus.git
