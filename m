From: Mirza Krak <mirza.krak@gmail.com>
Subject: Re: SocketCAN device enumeration API
Date: Tue, 9 Aug 2016 14:33:38 +0200
Message-ID: <CALw8SCV-90K_xCxT+XsUbN4cctOkhnxp_EeKgQROC=sgvKVcLg@mail.gmail.com>
References: <201d5fca-9ea8-aa0e-843e-f21441cd7170@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33690 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbcHIMdk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Aug 2016 08:33:40 -0400
Received: by mail-qk0-f193.google.com with SMTP id x189so883698qkd.0
        for <linux-can@vger.kernel.org>; Tue, 09 Aug 2016 05:33:40 -0700 (PDT)
In-Reply-To: <201d5fca-9ea8-aa0e-843e-f21441cd7170@gmx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andr=C3=A9_Hartmann?= <aha_1980@gmx.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

2016-08-09 13:06 GMT+02:00 André Hartmann <aha_1980@gmx.de>:
> Hello all,
>
> I'm one of the developers working on the new QtSerialBus module [0], [1]
> which encapsulates different CAN hardware drivers (including SocketCAN) in a
> C++ API.

Interesting. As a Qt user/developer I have wondered why this kind of
module has not existed earlier :).

>
> For a new hardware enumerating function, I'd like to do the following:
>
> * Enumerate the currently available (i.e. ready to use)
>   SocketCAN devices
> * Get hardware information/manufacturer/bus type for a device
> * Find out if a device is virtual
> * Find out if a device is CAN FD capable
>
> Is there already a possibility to do this from a C/C++ program?
> Some information can be parsed from the ip command output, but I'd rather
> use a real API.

Most of it could probably be done from C/C++.

Some of this has been discussed earlier. Did some digging and found
[1]. There might all ready be something similar in Qt, see [2], which
could probably partially work since SocketCAN devices are exposed as
network devices.

Other good resources could be libsocketcan [3] which uses netlink to
configure and retrieve information about the devices.

Best Regards
Mirza

[1]. https://marc.info/?l=linux-can&m=142757462432402&w=2
[3]. http://doc.qt.io/qt-4.8/qnetworkinterface.html#QNetworkInterface
[3]. http://www.pengutronix.de/software/libsocketcan/download/
