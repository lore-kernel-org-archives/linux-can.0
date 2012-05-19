From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Strange error with jspy utility
Date: Sat, 19 May 2012 07:15:17 +0200
Message-ID: <20120519051517.GA416@vandijck-laurijssen.be>
References: <CA+cPUuTWRQQ0qBnP1pE34wbMHF1OqXoBq5LkwQzkMgWFOyuzrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:34606 "EHLO
	mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752202Ab2ESFPU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 19 May 2012 01:15:20 -0400
Content-Disposition: inline
In-Reply-To: <CA+cPUuTWRQQ0qBnP1pE34wbMHF1OqXoBq5LkwQzkMgWFOyuzrA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Abdul Khan <akhan@symboticware.com>
Cc: linux-can@vger.kernel.org

Hi Abdul,

Thanks for your intrest in can-j1939.
It appears you got quite far yet.

From your story, I assume you connected can0 & can1 together?

> I am facing strange error with jspy utility provided with j1939-utils
I cannot look on your CAN bus. I'd need a raw CAN dump too
if I want to really debug this remotely.

> #./jsr can0:20,feda | ./jsr can1:40,feda
Here, you connect 2 jsr instances together via a pipe also.
I think you created a loop here.

I'm not trying to find out how this would react.
'jsr' is meant as program to send stdin to j1939 &
receive j1939 to stdout. It's not well documented
since it's a kind of test program ... :-)

I think what you wanted to do is this:

$ ./jsr can0:20,feda &
$ echo "hello" | ./jsr can1:40,feda

Then, you will see the seond instance of jsr terminating
quite soon, after having sent 1 packet.
The first instance of jsr will receive that (via CAN) and print
on stdout.

$ jspy
should then show 1 packet.

Kind regards,
Kurt

> 
> Thanks in advance.
> Abdul.
