From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] cangen: allow double value for gap
Date: Fri, 13 Jul 2012 07:43:08 +0200
Message-ID: <4FFFB56C.2040909@hartkopp.net>
References: <1342016592-1401-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:23367 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262Ab2GMFnK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jul 2012 01:43:10 -0400
In-Reply-To: <1342016592-1401-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

On 11.07.2012 16:23, Alexander Stein wrote:

> This way a user can specify a gap below 1ms. This is somehwat similar
> to setting the gap to 0, but the ENOBUFS are greatly reduced, so a given
> amount of CAN messages by -n is still usefull and useable.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>


Applied to can-utils.

Nice idea!

Regards,
Oliver
