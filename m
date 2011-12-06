From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: WG: PCAN-USB: new socketCAN driver available
Date: Tue, 06 Dec 2011 21:40:12 +0100
Message-ID: <4EDE7DAC.3090709@hartkopp.net>
References: <4E400A36.5050303@hartkopp.net> <A46279271E5345AC9BFA91C73DF57228@DA310MM05> <4E415AB2.5030102@hartkopp.net> <2CD045C79786404EA0A81CED1E59763D@DA310MM05> <4E4BFF24.2010508@hartkopp.net> <33575A72304940CE9103338BA3660CEA@DA310MM05> <26B4E6A46012A1469B4EB3BC2A7CAAEC01266CCC@vwagwox00084.vw.vwg> <4EC6597A.8040704@peak-system.com> <4EC6B080.8090808@hartkopp.net> <4ECB65D8.7050207@peak-system.com> <4ECB8E75.7@volkswagen.de> <4ECBAAFB.8080204@peak-system.com> <4ECBAE4E.8000502@volkswagen.de> <4ECBB49A.2020508@volkswagen.de> <4ED3B355.70209@peak-system.com> <26B4E6A46012A1469B4EB3BC2A7CAAECE55502@vwagwox00084.vw.vwg> <4ED3CC05.6060606@hartkopp.net> <4ED4AF93.8060309@peak-system.com> <4EDE71B6.6090805@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:16667 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab1LFUkL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2011 15:40:11 -0500
In-Reply-To: <4EDE71B6.6090805@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: "Maidhof, Michael" <m.maidhof@peak-system.com>, linux-can@vger.kernel.org

On 06.12.2011 20:49, Oliver Hartkopp wrote:

>> +config CAN_PEAK_PCAN_USB_PRO
> 
> CAN_PEAK_USB_PRO
> 
>> +       tristate "PEAK-System's PCAN-USB-PRO adapter"
> 
> "PEAK PCAN USB Pro adapter"
> 
>> +       select CAN_PEAK_USB
> 
> remove the select (see Makefile comment below)
> 
>> +       ---help---
>> +         This driver is for the two channels PCAN-USB-PRO interface
> 
> PCAN-USB Pro
> 
>> +         from PEAK-System (http://www.peak-system.com).
>> +
>> +config CAN_PEAK_USB
>> +       tristate
>> +
> 
> Remove this.
> 
> To select config entries should be omitted if possible.


I just tried out the suggestion myself ...

As my idea was to link the common functions directly to the module binary this
may double the needed size. Maybe your approach is really better 8-)

But the fact that the select should be omitted is still true.

Better you define a

config CAN_PEAK_USB
	tristate "PEAK System USB adapters"

and then

config CAN_PCAN_USB
	tristate "PEAK PCAN USB adapter"
	depends on CAN_PEAK_USB


config CAN_PCAN_USB_PRO
	tristate "PEAK PCAN USB Pro adapter"
	depends on CAN_PEAK_USB

...

Regards,
Oliver
