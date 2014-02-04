From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: AW: netlink error -95 (Operation not supported) with can-utils/cangw
Date: Tue, 04 Feb 2014 12:37:37 +0100
Message-ID: <52F0D101.6050500@hartkopp.net>
References: <18F8639CFC8C7C4D819AB347808079D4026C69FC@pluto.office.rac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:8329 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbaBDLho (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2014 06:37:44 -0500
In-Reply-To: <18F8639CFC8C7C4D819AB347808079D4026C69FC@pluto.office.rac.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sandro Anders | CarMedialab <sandro.anders@carmedialab.com>, linux-can@vger.kernel.org

Hi Sandro,

did you load the can-gw module?

When can-gw is not loaded the netlink functions for cangw are not registered.

Regards,
Oliver

On 04.02.2014 11:55, Sandro Anders | CarMedialab wrote:
> Hi all,
> 
> I was able to compile the can-utils/* apps without any errors and the
> most are working. But if I call the cangw command I get the following
> error message: cangw -A -s can1 -d can3
> netlink error -95 (Operation not supported)
> 
> Both CAN's are up and running. My assumption is that there is some
> netlink support missing in my Kernel, isn't it? Thanks for your help.
> 
> Sandro 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
