From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/3 V3.1] can/usb: PEAK-System Technik PCAN-USB specific
 part
Date: Fri, 20 Jan 2012 18:32:15 +0100
Message-ID: <4F19A51F.6040702@grandegger.com>
References: <Pine.LNX.4.44L0.1201191004540.1447-100000@iolanthe.rowland.org> <4F191D44.9080101@hartkopp.net> <4F195E08.5010504@volkswagen.de> <4F195F46.6080102@grandegger.com> <4F195FD7.9070808@grandegger.com> <4F196E1A.9020005@volkswagen.de> <4F19718A.7020801@grandegger.com> <4F197FEA.10007@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:48262 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874Ab2ATRcS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2012 12:32:18 -0500
In-Reply-To: <4F197FEA.10007@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can Mailing List <linux-can@vger.kernel.org>, stern@rowland.harvard.edu

Hi Stephane,

On 01/20/2012 03:53 PM, Stephane Grosjean wrote:
> Hi,
> 
> Found time to answer to all of you:
> 
> - first, thanks for your review and tests
> - next, I did a new version of the driver which fixes Alan's issue about
> the variables in the stack, and which is *very* much less verbose too.
> - the driver itself sets now the can state according to some usb adapter
> events
> 
> When unplugging the can cable, candump displays now:
> 
>   can4  20000004  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
>         controller-problem{rx-error-passive,tx-error-passive}
>   can4  20000004  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
>         controller-problem{rx-error-passive,tx-error-passive}
>   can4  20000004  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
>         controller-problem{rx-error-passive,tx-error-passive}
>   can4  20000004  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
>         controller-problem{rx-error-passive,tx-error-passive}
> ...

Does the device report state change to error *warning* as well? Also,
the state change to error passive should only be reported *once*. Well,
it's state change. I don't known what the hardware is actually
reporting. If it does report the current state periodically, you need to
handle it accordingly.
BTW: are the error counters also availabe/readable?

Wolfgang.
