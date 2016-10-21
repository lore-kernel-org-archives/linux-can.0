From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Adding new CAN driver
Date: Fri, 21 Oct 2016 18:37:41 +0200
Message-ID: <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:21769 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbcJUQhs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 21 Oct 2016 12:37:48 -0400
In-Reply-To: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Hello Remik,

On 10/20/2016 11:11 AM, Kołłątaj, Remigiusz wrote:
> Hello,
>
> I have created SocketCAN driver for Michrochip CAN BUS Analyzer
> (details: https://github.com/rkollataj/mcba_usb). I would like to
> upstream it, but as I've never done it before I want to make sure I
> will take proper steps.
>
> My understanding is that I should merge my changes with
> linux-can-next/master, generate patch and send it to this list. Is
> that right?

Yes :-)

'git send-email' is easy to use and the best way to send stuff to the 
mailing list.

I was just looking through your code and wondered whether we should 
support the termination switching feature via 'ip' tool or via sysfs.

Just added Marc in CC.

Regards,
Oliver

