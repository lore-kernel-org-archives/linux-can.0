From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] K-Line protocol via SocketCAN
Date: Fri, 20 May 2016 08:28:45 +0200
Message-ID: <573EAE9D.20006@hartkopp.net>
References: <573E491E.1000906@denx.de>
 <CAJ=nTsu_bJgj1A5JNJNAd9HAao5493CnofbQpJ_qftYOiCgaYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:51554 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbcETG26 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 May 2016 02:28:58 -0400
In-Reply-To: <CAJ=nTsu_bJgj1A5JNJNAd9HAao5493CnofbQpJ_qftYOiCgaYw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>, Marek Vasut <marex@denx.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hi,

I removed Dave Miller from the discussion not to be tagged as SPAM :-)
That's not Daves focus as networking maintainer ...

Here's an update about the LIN Status from Pavel Pisa:

http://marc.info/?l=linux-can&m=146163127517268&w=2

I remember a K-Line implementation for Linux where we had a MPC5200 UART 
which we programmed with bit-banging of some control line to do the 
5bit/s opening pattern.
After that we went to 10400 bit/s and did some K-Line communication.
All this was done by a user space application on /dev/ttyS0.

What would be the advantages to put this into kernel space (or into the 
CAN networking infrastructure)?

Regards,
Oliver


On 05/20/2016 08:04 AM, Mirza Krak wrote:
> 2016-05-20 1:15 GMT+02:00 Marek Vasut <marex@denx.de>:
>> I will also need to add support for the LIN protocol and SENT protocol
>> further down the line. I will also likely revisit the Arinc at some
>> point afterward. So I would like to know how to deal with this protocol
>> mess.
>
> FYI, there has been a similar LIN project for quite a while [1]. You
> might have seen it earlier?
>
> [1]. http://rtime.felk.cvut.cz/gitweb/linux-lin.git
>
