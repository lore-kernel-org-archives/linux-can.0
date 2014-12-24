From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH 4/5] use line discipline number from linux/tty.h
Date: Tue, 23 Dec 2014 22:20:16 -0800
Message-ID: <20141224062016.GA32193@hudson.localdomain>
References: <1419002540-2208-1-git-send-email-jmmahler@gmail.com>
 <1419002540-2208-5-git-send-email-jmmahler@gmail.com>
 <5499A9DD.5050109@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:40179 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbaLXGUV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Dec 2014 01:20:21 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so9479231pad.13
        for <linux-can@vger.kernel.org>; Tue, 23 Dec 2014 22:20:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5499A9DD.5050109@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Oliver,

On Tue, Dec 23, 2014 at 06:43:57PM +0100, Oliver Hartkopp wrote:
> Hello Jeremiah,
> 
> thanks for your improvements!
> 
> On 19.12.2014 16:22, Jeremiah Mahler wrote:
> >The line discipline number is provided in include/linux/tty.h.
> >Use that instead of a #define in each program.
> 
> I have a toolchain which is based on 2.6.18 kernel includes.
> So I probably have to patch the can-utils when building the latest version
> of can-utils with my 'old' toolchain now.
> 
Hmm, backward compatibility is good too.

As long as LDISC_N_SLCAN doesn't change the old way will work on every
system.  Maybe we should just leave it that way.

> Btw. you are right to use the common includes and remove this kind of hack.
> 
> So I applied your patches 1-4.
> 
> The UDEV rules are interesting too. But I wonder if a new 'doc' directory is
> the right place for it. Currently the can_if script to set the CAN interface
> bitrates and other configurations is placed in the can-misc repository in
> the 'etc' directory.
> 
I wasn't sure about this either.

Debian packages often place example configuration files in doc/examples.
This is what I had in mind, except I left out examples/ because two
directory levels for two files seemed excessive.

Using etc/ does make logical sense for system wide configuration files.
Some projects also use conf/ or config/.

I imagined these scripts being useful as examples.  But they certainly
could be installed system wide since the commands are not specific to
any user.  The can-utils .deb package could install these for example.

> This is probably a wrong place too.
> 
> I have no real idea where to put these kind of useful scripts ...
> 

I am starting to like the etc/ directory for system wide config files.

If these were user specific configuration files, like '.slcanrc', they
would make sense in a doc/examples directory.

> Regards,
> Oliver
> 

-- 
- Jeremiah Mahler
