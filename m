From: Oliver Pajonk <oliver@pjnk.de>
Subject: Re: can-isotp-modules
Date: Wed, 04 Nov 2015 07:59:05 +0100
Message-ID: <44220b4fed9da26bb9ba1b9c2ec885c4@pjnk.de>
References: <zarafa.56393552.66d8.60d6be43600a8a08@euve35974.vserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vps.pjnk.de ([92.51.145.123]:37880 "EHLO vps.pjnk.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbbKDHG5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 4 Nov 2015 02:06:57 -0500
In-Reply-To: <zarafa.56393552.66d8.60d6be43600a8a08@euve35974.vserver.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: linux-can@vger.kernel.org, linux-can-owner@vger.kernel.org


Hi Michael,

I was struggeling to compile ISO-TP as well (on my Raspi), but then I 
found this script (it was mentioned in some other mailing list post):

https://github.com/hartkopp/can-isotp-modules/blob/master/net/can/make_isotp.sh

That worked just fine. Maybe it helps?

Best regards,
Oliver

On 2015-11-03 23:29, Michael Luxen wrote:
> Hello Oliver,
> 
> today I've tried to install can-isotp-modules on my BeagleBone Black by
> 
> 1. git clone https://github.com/hartkopp/can-isotp-modules/
> 2. cd can-isotp-modules
> 3. make
> 
> The make process on my Debian Jessie 8.2 (uname -r: 4.1.6-ti-r16)
> powered BBB ends up with:
> 
> root@beaglebone:~/can-isotp-modules# make
> make -C /lib/modules/4.1.6-ti-r16/build M=/root/can-isotp-modules
> modules TOPDIR=/root/can-isotp-modules
> make[1]: Entering directory '/usr/src/linux-headers-4.1.6-ti-r16'
>   CC [M]  /root/can-isotp-modules/drivers/net/can/vcan.o
> In file included from include/linux/module.h:17:0,
>                  from 
> /root/can-isotp-modules/drivers/net/can/vcan.c:44:
> /root/can-isotp-modules/drivers/net/can/vcan.c: In function 
> '__check_echo':
> include/linux/moduleparam.h:377:61: warning: return from incompatible
> pointer type
>   static inline type __always_unused *__check_##name(void) { return(p); 
> }
>                                                              ^
> include/linux/moduleparam.h:428:35: note: in expansion of macro 
> '__param_check'
>  #define param_check_bool(name, p) __param_check(name, p, bool)
>                                    ^
> include/linux/moduleparam.h:145:2: note: in expansion of macro
> 'param_check_bool'
>   param_check_##type(name, &(value));       \
>   ^
> include/linux/moduleparam.h:125:2: note: in expansion of macro
> 'module_param_named'
>   module_param_named(name, name, type, perm)
>   ^
> /root/can-isotp-modules/drivers/net/can/vcan.c:91:1: note: in
> expansion of macro 'module_param'
>  module_param(echo, bool, S_IRUGO);
>  ^
>   CC [M]  /root/can-isotp-modules/drivers/net/can/slcan.o
> /root/can-isotp-modules/drivers/net/can/slcan.c:46:24: fatal error:
> asm/system.h: No such file or directory
>  #include <asm/system.h>
>                         ^
> compilation terminated.
> scripts/Makefile.build:264: recipe for target
> '/root/can-isotp-modules/drivers/net/can/slcan.o' failed
> make[3]: *** [/root/can-isotp-modules/drivers/net/can/slcan.o] Error 1
> scripts/Makefile.build:403: recipe for target
> '/root/can-isotp-modules/drivers/net/can' failed
> make[2]: *** [/root/can-isotp-modules/drivers/net/can] Error 2
> Makefile:1384: recipe for target '_module_/root/can-isotp-modules' 
> failed
> make[1]: *** [_module_/root/can-isotp-modules] Error 2
> make[1]: Leaving directory '/usr/src/linux-headers-4.1.6-ti-r16'
> Makefile:42: recipe for target 'modules' failed
> make: *** [modules] Error 2
> 
> 
> Any idea/hint how to fix this issue?
> 
> Regards
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
