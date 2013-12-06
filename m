From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] linux-can-next: Changes to Documentation (can.txt)
Date: Fri, 06 Dec 2013 11:13:04 +0100
Message-ID: <52A1A330.3030906@hartkopp.net>
References: <1386320652-18070-1-git-send-email-johnfwhitmore@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p04-ob.rzone.de ([81.169.146.178]:54363 "EHLO
	mo-p04-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543Ab3LFKTS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2013 05:19:18 -0500
In-Reply-To: <1386320652-18070-1-git-send-email-johnfwhitmore@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Whitmore <johnfwhitmore@gmail.com>
Cc: hardbyte@gmail.com, linux-can@vger.kernel.org, rob@landley.net

Hello John,

some small nitpicks:

On 06.12.2013 10:04, John Whitmore wrote:
> Changed MAINTAINERS File to add Documentation/networking/can.txt to the list

File -> file

> of maintained files.
> 
> can.txt:
>   - Globally changed Socket CAN to SocketCAN,
>   - Removed section 3.3 from the document,

why is the comma here?

>   - Updated Section 7
>   - Corrected a few simple typos.

and the point here?


> -7. Socket CAN resources
> +7. SocketCAN resources
>  -----------------------
>  
> -  You can find further resources for Socket CAN like user space tools,
> -  support for old kernel versions, more drivers, mailing lists, etc.
> -  at the BerliOS OSS project website for Socket CAN:
> -
> -    http://developer.berlios.de/projects/socketcan
> -
> -  If you have questions, bug fixes, etc., don't hesitate to post them to
> -  the Socketcan-Users mailing list. But please search the archives first.
> +  The Linux CAN / SocketCan project ressources (project site / mailing list)

SocketCan -> SocketCAN

> +  are referenced in the MAINTAINERS file in the Linux source tree.
> +  Search for CAN NETWORK [LAYERS|DRIVERS].
>  

You can add my

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

in patch v3.

Many thanks,
Oliver

