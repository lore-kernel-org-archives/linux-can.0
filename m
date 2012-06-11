From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v5] CAN FD support
Date: Mon, 11 Jun 2012 16:26:15 +0200
Message-ID: <4FD60007.8070801@grandegger.com>
References: <4FC3D9EE.4010807@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:39887 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab2FKO0R (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Jun 2012 10:26:17 -0400
In-Reply-To: <4FC3D9EE.4010807@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 05/28/2012 10:02 PM, Oliver Hartkopp wrote:
> Hi all,
> 
> since RFC v4 - see http://marc.info/?l=linux-can&m=133708871921901&w=2 from
> 2012-05-15 - i cleaned up some details and added the support of simultaneous
> CAN and CANFD frame handling inside the networking code after some discussion
> with Kurt. Sometimes code needs to be implemented to see that there is a more
> elegant solution out there when removing that code again ;-)
> 
> If you also feel fine with this patch i would finally create a patchset of
> four patches, like 
> 
> - adding new structures and constants
> - adding CAN FD support in af_can.c
> - adding CAN FD support in raw.c
> - adding CAN FD support in vcan.c
> 
> for the upcoming net-next bound for Linux 3.6 .

Do you have already CAN FD hardware for testing? If not, do we really
want to have this patchset mainline.

More later...

Wolfgang.
