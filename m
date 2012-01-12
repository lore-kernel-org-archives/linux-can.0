From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: loopback/recv own messages option not working as expected with
 plx_pci (Adlink Technology PCI-7841)
Date: Thu, 12 Jan 2012 17:57:45 +0100
Message-ID: <4F0F1109.6090300@hartkopp.net>
References: <CAJsOQGNE959CjAJUCQzxqh_zyrLj-Ed=-RDYBvJq9OrtScMkKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:25874 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab2ALQ6H (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Jan 2012 11:58:07 -0500
In-Reply-To: <CAJsOQGNE959CjAJUCQzxqh_zyrLj-Ed=-RDYBvJq9OrtScMkKw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Felix Obenhuber <felix@obenhuber.de>
Cc: linux-can@vger.kernel.org

Hi Felix,

On 12.01.2012 14:53, Felix Obenhuber wrote:


> I just encountered a problem with the loopback and receive own
> messages option in combination with the plx_pci driver serving a
> Adlink PCI-7841. It driver behaves a the CAN_RAW_RECV_OWN_MSGS and
> LOOPBACK option would have been set (and they aren't).
> 
> One box with the Adlink card connected to another host with a approved
> and well initialized CAN card. Sending single frames from each hosts
> works fine. When I start the canecho test from trunk/test and send a
> frame on  the bus (from the other node) its duplicated each time
> canecho reads/writes the frame. You would get the same result if you
> set the CAN_RAW_RECV_OWN_MSGS and LOOPBACK option on the socket in the
> canecho test.
> I have the same behavior with a tool written by me and tested with the
> latest trunk revision - same result.
> Running canecho on a vcan or peak usb device works as expected.


Both vcan & the PEAK driver use a fallback solution for that - so it is not a
real statement when they work.

> 
> Has someone seen something similar with that driver? I'd just like to
> ask before digging into it.


No - i assume you are using a 2.6.30.x (0 <= x < 5) kernel, right?

See

http://old.nabble.com/Local-loopback-broken--td24108048.html

Regards,
Oliver
