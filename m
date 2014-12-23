From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 4/5] use line discipline number from linux/tty.h
Date: Tue, 23 Dec 2014 18:43:57 +0100
Message-ID: <5499A9DD.5050109@hartkopp.net>
References: <1419002540-2208-1-git-send-email-jmmahler@gmail.com> <1419002540-2208-5-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:27338 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbaLWRoH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Dec 2014 12:44:07 -0500
In-Reply-To: <1419002540-2208-5-git-send-email-jmmahler@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jeremiah Mahler <jmmahler@gmail.com>
Cc: linux-can@vger.kernel.org

Hello Jeremiah,

thanks for your improvements!

On 19.12.2014 16:22, Jeremiah Mahler wrote:
> The line discipline number is provided in include/linux/tty.h.
> Use that instead of a #define in each program.

I have a toolchain which is based on 2.6.18 kernel includes.
So I probably have to patch the can-utils when building the latest version of 
can-utils with my 'old' toolchain now.

Btw. you are right to use the common includes and remove this kind of hack.

So I applied your patches 1-4.

The UDEV rules are interesting too. But I wonder if a new 'doc' directory is 
the right place for it. Currently the can_if script to set the CAN interface 
bitrates and other configurations is placed in the can-misc repository in the 
'etc' directory.

This is probably a wrong place too.

I have no real idea where to put these kind of useful scripts ...

Regards,
Oliver

