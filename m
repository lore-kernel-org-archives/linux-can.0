From: John Whitmore <arigead@gmail.com>
Subject: Re: mcp251x: mcp2515 stops receiving
Date: Sat, 29 Mar 2014 18:15:22 +0000
Message-ID: <20140329181521.GB31437@griso.site>
References: <2E9F00CBB66AB544A1ACDC59627518BA0DB3F120@mailserver>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53737 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbaC2SNt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 29 Mar 2014 14:13:49 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so334960wib.11
        for <linux-can@vger.kernel.org>; Sat, 29 Mar 2014 11:13:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2E9F00CBB66AB544A1ACDC59627518BA0DB3F120@mailserver>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Rost, Martin" <Martin.Rost@tonfunk.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Sorry Martin just catching up with this list.

On Fri, Mar 21, 2014 at 12:40:30PM +0000, Rost, Martin wrote:
> Hello List,
> 
> We are using the MCP2515 on a tegra3 (Toradex Colibri T30, to be precise) and every now and then the driver just stops.
> The interrupt line stays low, and the driver does not collect the data.
> From my investigations I conclude, that the MCP lowers the IRQ line before the value in the INTF register is  updated, 
> so when the driver reads the INTF register, a 0 is returned, and the driver assumes nothing has to be done.
>  

What you have described is something that I've been getting with the
MCP2515. I do have the MCP2515 connected on the RPi, but I've not been using
that setup for a few weeks. I'm currently working with a MCP2515 connected to
a Microchip PIC24 and cannot get the MCP2515 to work in Interrupt mode as it
triggers an Interrupt but the Flags are zero indicating that there is no
interrupt so my driver does nothing and the interrupt line is locked low. I
can only get the 2515 to work in polled mode. 

All that is of no help to you but I'll have a look at my RPi setup and really
test it on a network and see if I can recreate that problem there. 
 

> (
> Chances are I'm misinterpreting my observations. 
> It might as well be that the call to the IST is suspended, because the previous instance is still running and processes the new irq cause as well, 
> so the next call will not see the signal at all. 
> But in that case the driver should not stop with the irq line held low, or should it?
> )
>  
> We are using the 3.1.10 kernel from the toradex repository, which should be in sync with the nvidia tegra4linux one.
> I have browsed through the patches between 3.1.10 and head and have applied all those that seem to address issues and don't interfere with the 3.1.10 kernel structures, but to no avail.
> In fact, these patches have been applied:
> cab32f39dcc5b35db96497dc0a026b5dea76e4e7
> db388d6460ffa53b3b38429da6f70a913f89b048
> ae5d589e5f9f3217656ada632869968178886ac6
> b1ef05a5a20afe50d4188a5b59579bd140758cf0
> I have changed the IST loop to poll the INTF register beforehand for up to 10ms, and now the driver seems a lot more stable in our environment.
> Has someone seen this issue before, or can confirm I am not completely off the path?
>  
> On a side note, I have a second reason that makes the driver stop, which has to do with smp somehow.
> Disabling core1..3 keeps that from happening, but the problem addressed above would persist.
> Switching the irq to a different core by setting /proc/irq/91/smp_affinity does not trigger this problem.
> Any insights or starting point on this would also be greatly appreciated.
>  
> Best regards
> Martin 


