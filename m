From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: Xilinx Zynq CAN driver
Date: Fri, 3 Jan 2014 14:40:09 +0100
Message-ID: <15ba5e14-8553-4b02-94b6-91b1a8e93691@DB8EHSMHS025.ehs.local>
References: <52C69E61.1030203@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db8lp0189.outbound.messaging.microsoft.com ([213.199.154.189]:4316
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752175AbaACNkS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Jan 2014 08:40:18 -0500
In-Reply-To: <52C69E61.1030203@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Kedareswara rao Appana <appanad@xilinx.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

On 01/03/2014 12:26 PM, Oliver Hartkopp wrote:
> Hello Michal,
> 
> your update patch for the MAINTAINERS file ("MAINTAINERS: set up proper
> record for Xilinx Zynq")
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c2fd4e38032239746badb0e21d72c3a00438feac
> 
> pointed me to your Xilinx repository hosted at github.
> 
> There I've seen that there's already a netdevice driver for your Zynq CAN
> controller: 
> 
> https://github.com/Xilinx/linux-xlnx/blob/master/drivers/net/can/xilinx_can.c
> 
> IMHO the commit is already in pretty good shape: 
> 
> https://github.com/Xilinx/linux-xlnx/commit/cca204594df616b02c63f91a8b176c2665be57ea
> 
> Probably there are only some smaller formatting things to fix, e.g. remove
> some debug stuff ...
> 
> Btw. is there anything that prevents you from posting your existing driver on
> the linux-can mailing list for mainline upstream?
> 
> Having this driver in Linux mainline would at least reduce your out-of-tree
> maintenance.

We are in process of validation of our drivers and they will be send to mainline
soon. I was in touch with Marc regarding can driver testing which we need to do.

Thanks,
Michal


