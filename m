From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH can-utils 3/3] slcand: remove program as it is undistributable
Date: Sun, 12 Jan 2014 20:54:47 +0100
Message-ID: <CAGm1_ktO3VxEG++Sq8s2dDJO3zZFr8O58QMs9oazr0N5zPvMyg@mail.gmail.com>
References: <20130817190521.GK30496@pengutronix.de> <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1389481823-8379-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAGm1_ksVCPftbN_9BzS6tJ+-WWmfckegSQ9h_8USnNdKKfW01w@mail.gmail.com>
 <52D27518.5040202@hartkopp.net> <CAGm1_kuooN2PUQGAEqhG=59qJWT-10F0yvAQWVgnS9jDXnB05Q@mail.gmail.com>
 <52D2DD7B.2070003@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:56312 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaALTzJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jan 2014 14:55:09 -0500
Received: by mail-bk0-f43.google.com with SMTP id mz12so2184352bkb.16
        for <linux-can@vger.kernel.org>; Sun, 12 Jan 2014 11:55:07 -0800 (PST)
In-Reply-To: <52D2DD7B.2070003@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

On Sun, Jan 12, 2014 at 7:22 PM, Oliver Hartkopp <socketcan@hartkopp.ne=
t> wrote:
>
>
> On 12.01.2014 17:09, Yegor Yefremov wrote:
>> On Sun, Jan 12, 2014 at 11:57 AM, Oliver Hartkopp
>> <socketcan@hartkopp.net> wrote:
>>>
>>>
>>> On 12.01.2014 00:38, Yegor Yefremov wrote:
>>>> On Sun, Jan 12, 2014 at 12:10 AM, Uwe Kleine-K=C3=B6nig
>>>> <u.kleine-koenig@pengutronix.de> wrote:
>>>>> The source file specifies slcand to be licensed under both GPL-2+=
 and GFDL.
>>>>> These two licenses are incompatible which makes this file undistr=
ibutable.
>>>>> The clean way to fix this is to remove the file and reimplement i=
ts
>>>>> functionality under a valid license when need arises.
>>>>
>>>> There is need for this daemon. I'm using it in production tests.
>>>>
>>>
>>> Oh, yes. There was so much effort put into this slcand.
>>> We should better look how we might fix the license issues.
>>>
>>> The original thread where slcand comes from was here:
>>>
>>> http://socket-can.996257.n3.nabble.com/slcan-attach-and-resetting-l=
ine-disciplines-td1396.html
>>>
>>> And here was the original commit to the SVN:
>>> http://svn.berlios.de/wsvn/socketcan/trunk/can-utils/slcand.c?rev=3D=
973&peg=3D973
>>>
>>> The code has been removed from Wikipedia in October 2009
>>> http://en.wikipedia.org/w/index.php?title=3DDaemon_%28computing%29&=
diff=3D321383226&oldid=3D320644717
>>> (not a textbook. these examples are completely opaque to non-expert=
s)
>>>
>>> And it has been added here (wihout any license information):
>>> http://en.wikipedia.org/w/index.php?title=3DDaemon_%28computing%29&=
diff=3D273831207&oldid=3D273016660
>>>
>>> I assume we need to rewrite the daemon-specific code, e.g. use the
>>> other reference in Wikipedia:
>>>
>>>         http://www-theorie.physik.unizh.ch/~dpotter/howto/daemonize
>>>
>>> which is public domain - and I assume this to be the original sourc=
e ...
>>
>> Would this call do the job: http://man7.org/linux/man-pages/man3/dae=
mon.3.html?
>
> Yes, I think so.
>
> Here's a uClibc code for daemon()
> https://github.com/hwoarang/uClibc/blob/master-metag/libc/unistd/daem=
on.c
>
> As we do not need any 'specialties' for slcand (e.g. file i/o, loggin=
g, etc)
> this could shorten the slcand a lot.
>
> There are also some examples out there that could be adopted without =
getting
> into a licensing issue again:
> https://www.google.de/#q=3Dlinux+daemon+unistd

Would it be sufficient to submit a patch, that reimplements
daemonize() and fixes license? Instead of removing the file and
readding it?

Yegor
