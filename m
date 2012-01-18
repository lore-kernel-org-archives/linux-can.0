From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 0/3 v2] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Wed, 18 Jan 2012 14:17:32 +0100
Message-ID: <4F16C66C.8070007@grandegger.com>
References: <1326468404-19330-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59597 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397Ab2ARNRf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2012 08:17:35 -0500
In-Reply-To: <1326468404-19330-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Stephane,

On 01/13/2012 04:26 PM, Stephane Grosjean wrote:
> That serie of patches adds the peak_usb driver which handles the PCAN-USB
> and PCAN-USB Pro adapters from PEAK-System (http://www.peak-system.com).
> These patches are planned for kernel v3.02.00 and above.
>  
> Stephane Grosjean (3):
>   can/usb: PEAK-System Technik USB adapters driver core
>   can/usb: PEAK-System Technik PCAN-USB specific part
>   can/usb: PEAK-System Technik PCAN-USB Pro specific part

Looks almost good. Just a few more issues. When addressed, you can add
my "Acked-by: Wolfgang Grandegger <wg@grandegger.com>"  to the next
version of all patches, which should *also* go to the USB Linux and
netdev mainling list.

Thanks,

Wolfgang.
