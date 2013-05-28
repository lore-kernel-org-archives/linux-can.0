From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: problem to using CAN on beaglebone black A5A
Date: Tue, 28 May 2013 20:00:48 +0200
Message-ID: <51A4F0D0.3080107@grandegger.com>
References: <CABMxt4idBKa8tH4b4T4Z5AQir3UOOjvR1ocTv3OAN6Aqqtccpw@mail.gmail.com> <51A0A264.9060505@hartkopp.net> <CABMxt4hj-tqRD_aDk6QNMNyNiAjt9vNzb=4ziTpB28ZYAgH08A@mail.gmail.com> <51A1E56B.4010604@hartkopp.net> <CABMxt4h-0zYYBvjUqBdf=eChKXxJv77OPhQmh_y7rkwj18mdcQ@mail.gmail.com> <CABMxt4jMmBeMqFeyRMQ=5PtQtt6SHDGNGXUGm-WzPsW6Er9+SQ@mail.gmail.com> <51A4E30E.1080504@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:56999 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758122Ab3E1SAw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 28 May 2013 14:00:52 -0400
In-Reply-To: <51A4E30E.1080504@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Mohamed,

On 05/28/2013 07:02 PM, Oliver Hartkopp wrote:
> On 28.05.2013 01:04, Mohamed HAMZAOUI wrote:
>> I created a simple card with two CAN transeiver and connected to bbb card
>> in accordance with bbb datasheet.

It's difficult for us to guess what you are doing and using. Please
provide more information about your hardware and software:

- what hardware/board are you using?
- what Linux distribution are you using?
- what Linux kernel version are you using
- where did you get the Linux kernel from?

Also showing us your boot log (output of "# dmesg") and the kernel's
".config" would be help.

Wolfgang.


