From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Re: SocketCAN device enumeration API
Date: Thu, 11 Aug 2016 12:31:00 +0200
Message-ID: <4184b9d9-aac7-909c-5e04-3be1be7d30a7@gmx.de>
References: <201d5fca-9ea8-aa0e-843e-f21441cd7170@gmx.de>
 <20160809140453.GE25116@airbook.newtec.eu>
 <e7d06ad8-579d-0053-c7e5-ddc8feee673b@gmx.de>
 <20160811100558.GA2147@airbook.newtec.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:52914 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbcHKKbN (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 11 Aug 2016 06:31:13 -0400
In-Reply-To: <20160811100558.GA2147@airbook.newtec.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Mirza Krak <mirza.krak@gmail.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

Hi Kurt,

 > When you ship libenumif along with QT, doesn't that imply that it
 > should stay out of QT.
 > Or did you mean to ship libenumif as shared object along with QT's
 > shared objects?

I don't know how this is handled in general in the Qt project, I'm just 
an external contributor. I just know, that they have the source of some 
libraries included in 3rdparty subdirs. That code is build together with 
Qt for all supported platforms (Linux specific code is not compiled for 
Windows). I guess, the generated shared object files are then 
distributed along with Qt.

I assume the libraries source code needs to be copied into Qt's source 
tree, as otherwise lots of builds will break because of unsatisfied 
dependencies. Introducing more compile dependencies is a no-go I guess.

So I will have to ask the Qt developer mailing list how to proceed.

Best regards and thanks for your great work!

Andre

Am 11.08.2016 um 12:05 schrieb Kurt Van Dijck:
>> Hello Kurt and Mirza,
>>
>> thanks for your pointers, I did already did search time, but haven't found
>> much useful.
>>
>> Kurt, your library does exactly what I need. I was impressed (and a bit
>> shocked), how much code is necessary to do this work.
>
> I too think netlink was as such not designed to be an end-user
> interface, but a generic mechanism to create libraries like
> libsocketcan, of libenumif.
>
>> I think (parts of)
>> your library would also make a good extension to libsocketcan, as it seems
>> I'm not the only one asking, so there is definitely a need for this
>> function.
>
> Well, libsocketcan could copy part of the code for easy CAN enumeration.
> libenumif is not really restricted to CAN, or any other type.
>
>>
>> However, the only possiblity I see for me now, would be to ship a copy of
>> libenumif along with Qt and to integrate it into Qt's build system for
>> cross-platform builds.
>
> When you ship libenumif along with QT, doesn't that imply that it should
> stay out of QT.
> Or did you mean to ship libenumif as shared object along with QT's
> shared objects?
>
>>
>> Thats where my problems begin. I neither know about the technical, nor the
>> legal possibilities to do so :(
>
> QT is not my technical competence.
> Legally, libenumif is shipped with LGPLv3. I don't see a problem
> shipping it. LGPL allows to use the library (as shared object) from
> non-GPL code AFAIK.
>
> Kurt
>

