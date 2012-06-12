From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: socketcan: license issues
Date: Tue, 12 Jun 2012 10:45:57 +0200
Message-ID: <4FD701C5.6010207@hartkopp.net>
References: <1339484312-4281-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:34938 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab2FLIp6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Jun 2012 04:45:58 -0400
In-Reply-To: <1339484312-4281-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org

On 12.06.2012 08:58, yegorslists@googlemail.com wrote:

> During my effort bringing SocketCAN to Android I encountered following issue: Android devs found out that SocketCAN headers are not licensed as GPL2. See discussion here https://android-review.googlesource.com/#/c/34510/
> 
> I added GPL2 notion to the headers. Is it O.K. the way I made it or should we make this consistent for all SocketCAN files including the drivers?


Hello Yegor,

the stuff which is inside the kernel is GPL source.

No need to put any effort to change copyright notices in Kernel headers.

The Android guys can pick the headers as-is. They did it with xattr.h too:

See

https://github.com/android/platform_bionic/blob/master/libc/kernel/common/linux/xattr.h

and the original header starts with

/*
  File: linux/xattr.h

  Extended attributes handling.

  Copyright (C) 2001 by Andreas Gruenbacher <a.gruenbacher@computer.org>
  Copyright (c) 2001-2002 Silicon Graphics, Inc.  All Rights Reserved.
  Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
*/

http://lxr.linux.no/#linux+v3.4.2/include/linux/xattr.h

which also includes a copyright and "All rights reserved" message from SGI.

So why is there any problem with can.h when there was no problem with xattr.h?

The CAN subsystem is licensed by Volkswagen under GPL/BSD - the Android guys
are hereby invited to pick the headers for their libs - even when i personally
think, that their header cleaning process is a bad message for contributing
developers. 

Regards,
Oliver

