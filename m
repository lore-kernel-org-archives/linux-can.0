From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH RFC] Large file support (LFS) for can-utils
Date: Fri, 21 Feb 2014 21:36:47 +0100
Message-ID: <5307B8DF.2010908@hartkopp.net>
References: <5307B530.4010505@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:58976 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaBUUgu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Feb 2014 15:36:50 -0500
In-Reply-To: <5307B530.4010505@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Here's some more documentation about LFS:

http://www.gnupg.org/documentation/manuals/gpgme/Largefile-Support-_0028LFS_0029.html

There's also a autoconf macro AC_SYS_LARGEFILE

Regards,
Oliver

On 21.02.2014 21:21, Oliver Hartkopp wrote:
> Hi Uwe,
> 
> yesterday I tried to create a really big CAN logfile with
> 
> 	candump -l any
> 
> logging 9 CAN interfaces.
> 
> But unfortunately the length of the log file on my 32 bit i686 machine was
> limited to 2147483647 == 0x7FFFFFFF == int32 max ...
> 
> I did some investigation and there's some kind of large file support (LFS) in
> recent gnu libraries that allow 32 bit applications to create large files with
> file length values > 0x7FFFFFFF when the filesystem supports it.
> 
> When applying the patch below my candump was able to create a large log file.
> 
> Alternatively
> 
> 	candump -L any > filename
> 
> did the job too as obviously 'cat' has large file support ;-)
> 
> What do you think about LFS?
> Would this be the correct way to add the LFS support?
> 
> Regards,
> Oliver
> 
> Not-really-signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> ---
> 
> diff --git a/Makefile b/Makefile
> index ab99746..a926177 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -45,6 +45,7 @@ MAKEFLAGS = -k
> 
>  CFLAGS    = -O2 -Wall -Wno-parentheses -Iinclude \
>  	    -fno-strict-aliasing \
> +	    -D_FILE_OFFSET_BITS=64 \
>  	    -DSO_RXQ_OVFL=40 \
>  	    -DPF_CAN=29 \
>  	    -DAF_CAN=PF_CAN
> 
