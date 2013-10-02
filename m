From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Linux CAN CUSE hacks, SocketCAN and RT Was: adding can4linux to  drivers/char
Date: Wed, 02 Oct 2013 11:47:06 +0200
Message-ID: <028a4e468bfd8ec170a9ec287b8b7cc7@grandegger.com>
References: <1881932.U1kQQJkqCz@heinz.site>
 <206b49e0-6fcb-4895-8fca-19a9b38e6a18@email.android.com>
 <5B48DC5BA8D5D64A8F5E39AC7EF2A42008B864@ADXV3.win.desy.de>
 <201310021044.00281.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:58352 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913Ab3JBJrJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 2 Oct 2013 05:47:09 -0400
In-Reply-To: <201310021044.00281.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: "May, Stefan" <stefan.may@desy.de>, Oliver Hartkopp <socketcan@hartkopp.net>, =?UTF-8?Q?Heinz-J=C3=BCrgen_Oertel?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org, Michal Sojka <sojkam1@fel.cvut.cz>

On Wed, 2 Oct 2013 10:43:59 +0200, Pavel Pisa <pisa@cmp.felk.cvut.cz>

wrote:

> Hello All,

> 

> I monitor this discussion for longer time.

> Unfortuantelly I am quite out of time and we need some more

> testing of newer kernels with SocketCAN and some alternatives

> to backup my observations. But I cannot stay longer silent.

> 

> On Tuesday 01 of October 2013 22:20:55 May, Stefan wrote:

>> > And add a CUSE adaption for your legacy costumers.

>>

>> CUSE adaption is not possible in the case of can4linux API. I tried

that

>> once and failed. The reason is in read() and write() call where

can4linux

>> chooses to use the number of frames instead of bytes for the count

>> parameter.

> 

> Such choice is broken by design and I would beg and protest against

> inclusion of such thing into mainline. This is against POSIX

> read/write calls definitions. This breaks all tools like Valgrind

> and security checks etc. You can do so such weird things on Linux

> but under Windows KDM and WDM models with IRP packets you cannot.

> Same in many sane systems either. It breaks possible future

modifications

> of Linux to the more microkernel/hypervisor based design etc.

> (and yes, I am aware that there is/was similar brokenness in mainline

> kernel already somewhere in I2C code where read uses address provided

> in the first byte of buff which should be receive only, but at least

> size matches).

> 

> On Wednesday 02 of October 2013 09:49:12 Oliver Hartkopp wrote:

>> Btw. CUSE is open source.

>> Why not adding a feature to CUSE that allows to pass the number of

>> structs

>> instead of the number of bytes?

> 

> Please no, NO, I expect that CUSE maintainers would cry loud as well.



Yep and such a read/write implementation for a character device would

also not have any chance to be included in the mainline kernel.



Wolfgang.
