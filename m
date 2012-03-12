From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Automatic baud rate detection
Date: Mon, 12 Mar 2012 21:05:43 +0100
Message-ID: <4F5E5717.2080308@grandegger.com>
References: <18F8639CFC8C7C4D819AB347808079D40144C16B@pluto.office.rac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:42433 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639Ab2CLUFr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Mar 2012 16:05:47 -0400
In-Reply-To: <18F8639CFC8C7C4D819AB347808079D40144C16B@pluto.office.rac.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sandro Anders | CarMedialab <sandro.anders@carmedialab.com>
Cc: linux-can@vger.kernel.org

Hi Sandro,

On 03/12/2012 06:55 PM, Sandro Anders | CarMedialab wrote:
> Hi,
> 
> we currently developing our own socketcan driver and we have the
> requirement to auto detect the baud rate at load time. Our HW is
> supporting this but it seems this behavior is not configurable via IP
> tools. Maybe I am  wrong but has anyone an suggestion to do this? We
> thought to use baud rate 0 to detect this but this is obviously not
> allowed. 

Kernel space support for bitrate detection is not available or
implemented. But software driven bitrate detection should be possible
from user space by using the listen only mode. What hardware are you
speaking about? How does the hardware do the bitrate detection?

Wolfgang.
