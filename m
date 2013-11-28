From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: AW: Need support J1939 protocol support to my kernel (v3.8 on
 BeagleBone Black)
Date: Thu, 28 Nov 2013 09:52:33 +0100
Message-ID: <20131128085233.GA3146@vandijck-laurijssen.be>
References: <zarafa.5281024a.0b28.43b8b0d35b442ecc@v14647.1blu.de>
 <loom.20131112T015933-695@post.gmane.org>
 <20131112100222.GA3748@vandijck-laurijssen.be>
 <loom.20131128T053030-487@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:49507 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750846Ab3K1Iwi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Nov 2013 03:52:38 -0500
Content-Disposition: inline
In-Reply-To: <loom.20131128T053030-487@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: swapnil <patilswa@gmail.com>
Cc: linux-can@vger.kernel.org

Hey,

> Hi Kurt ,
>  Thanks for adding the information on elinux.org/J1939
> I am able to build the kernal for begabone black using j1939 
> but when i tried to build iproute2-j1939
> 
> root@arm:/home/ubuntu/OBDscan/iproute2-j1939# make
> make[1]: Entering directory `/home/ubuntu/OBDscan/iproute2-j1939/misc'
> gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -I../include -
> DRESOLVE_HOSTNAMES -DLIBDIR=\"/usr/lib/\" -I/usr//usr/include  -o arpd 
> arpd.c ../lib/libnetlink.a ../lib/libutil.a -ldb -lpthread
> arpd.c:19:20: fatal error: db_185.h: No such file or directory
>  #include <db_185.h>
>                     ^
> compilation terminated.
> make[1]: *** [arpd] Error 1
> make[1]: Leaving directory `/home/ubuntu/OBDscan/iproute2-j1939/misc'
> make: *** [all] Error 2
> 
> i am getting above error.
> i tried to install  sudo apt-get install db4.7-util
> but did not worked 

you'd need some sort of db-devel package, as explained in README of iprout2.
Another trick I initially did is disable arpd from building:
in misc/Makefile, drop 'arpd' from TARGETS.

Kind regards,
Kurt
