From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/1 V2] slcanpty: Improve the data handling from pty2can()
 to avoid, incomplete messages in further processing
Date: Sat, 08 Jun 2013 13:18:41 +0200
Message-ID: <51B31311.6080606@hartkopp.net>
References: <51AA491A.7060307@myvdr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:27375 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab3FHLSm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Jun 2013 07:18:42 -0400
In-Reply-To: <51AA491A.7060307@myvdr.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: uescher <linux-can_ger.kernel.org@myvdr.de>
Cc: linux-can@vger.kernel.org

On 01.06.2013 21:18, uescher wrote:
> slcanpty: Improve the data handling from pty2can() to avoid
>  incomplete messages in further processing
> 
> This Patch ensure that we have minimum one complete SLCAN messages from pty in
> our buf[]
> before we start the processing.
> Leave framgents of an messages in the buf[] and wait with processing until we
> have a '\r' in the buf[].
> 
> Signed-off-by: Ulrich Escher <git@myvdr.de>
> 
> 
> 

Hi Ulrich,

thanks for the fix!

Indeed I needed some time to get the point %-)

I removed all the debug stuff and added some comments to reduce the time to
get the point the next time i look into that code.

I changed the for() statement with the break to a simpler implementation.

Please check out the updated version which should do the same as your patch.

Best regards,
Oliver


