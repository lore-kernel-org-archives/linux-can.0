From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: BCM cyclic transmission tasks : cpu load
Date: Thu, 16 Apr 2015 19:59:59 +0200
Message-ID: <552FF89F.6030603@hartkopp.net>
References: <CAA_20DA1UmnyrMSOy8vS1HRyhMm7xbjta1BZdK9Gfe1x2MAXBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:49698 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbbDPSAH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Apr 2015 14:00:07 -0400
In-Reply-To: <CAA_20DA1UmnyrMSOy8vS1HRyhMm7xbjta1BZdK9Gfe1x2MAXBA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maxime Vinci <maxime.vinci@gmail.com>, linux-can <linux-can@vger.kernel.org>

Hi Maxime,

On 16.04.2015 19:28, Maxime Vinci wrote:
> This is my first message on a mailing list like this one, please be gentle ;)

Welcome. But beware - we are monsters :-)

> Currently, I am using the SocketCAN BCM feature to setup cyclic frame
> transmissions.
>
> Setting up everything appears to work fine : I can create multiple
> tasks with different periods, with one or more frames in each one.
>
> I would like to use it inside a Qt application (with qml based user
> interface), but it seems that right when I set up the first cyclic
> task, the cpu load increase from ~5% to 100%.
>
> Even when all tasks are deleted (by using the opcode TX_DELETE), the
> cpu load stays at the same level.
>
> To see if the UI was messing it up, I wrote a simple test program
> where I call the BCM functions to set up some cyclic tasks before
> entering a Qt application event loop (a simple "Hello world" app).
>
> It showed me that the cpu load goes crazy when the event loop starts.
>
> Correct me if I am wrong, but according to these 2 behaviors, it could
> be assumed that the issue happens every time the BCM and a Qt-based UI
> are being used together.
>
> Does anyone have any hints about this particular issue ?

I know about a colleague who's using Qt together with SocketCAN - but I'm not 
sure if he uses CAN_BCM sockets or only CAN_RAW. But AFAIK he implemented the 
communication stuff (including CAN access) into a separate thread.

So one suggestion would be to use strace (-> man strace) to check what's going 
on at syscall level. E.g. when your event loop does some blocking/polling 
stuff you can likely see it.

Regards,
Oliver

> PS: I did not try to put the object that wraps the BCM features in a
> new thread, but I think this will not solve the problem. (this is kind
> of done inside SocketCan, right ?)

Maybe you give it a try ;-)

