From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Re: SocketCAN device enumeration API
Date: Thu, 11 Aug 2016 10:36:07 +0200
Message-ID: <e7d06ad8-579d-0053-c7e5-ddc8feee673b@gmx.de>
References: <201d5fca-9ea8-aa0e-843e-f21441cd7170@gmx.de>
 <20160809140453.GE25116@airbook.newtec.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:59763 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764AbcHKIg0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 11 Aug 2016 04:36:26 -0400
In-Reply-To: <20160809140453.GE25116@airbook.newtec.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Mirza Krak <mirza.krak@gmail.com>

Hello Kurt and Mirza,

thanks for your pointers, I did already did search time, but haven't 
found much useful.

Kurt, your library does exactly what I need. I was impressed (and a bit 
shocked), how much code is necessary to do this work. I think (parts of) 
your library would also make a good extension to libsocketcan, as it 
seems I'm not the only one asking, so there is definitely a need for 
this function.

However, the only possiblity I see for me now, would be to ship a copy 
of libenumif along with Qt and to integrate it into Qt's build system 
for cross-platform builds.

Thats where my problems begin. I neither know about the technical, nor 
the legal possibilities to do so :(

The other possiblility according to Mirza's links seems to parse 
/sys/class/net/ - I will give this a try too.

QNetworkInterface gives me a list of interfaces, but has the same 
problems like a simple getifaddrs(), you cannot find out if an interface 
is of type CAN.

I also found this extension to libsocketcan:

https://github.com/ajneu/libsocketcan/commit/26ef

Is there any chance that this extension can be merged upstream? It 
contains the can_get_typekind function to query whether an interface is 
virtual or not.

Best regards,
Andre

