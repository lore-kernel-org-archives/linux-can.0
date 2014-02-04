From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: AW: netlink error -95 (Operation not supported) with can-utils/cangw
Date: Tue, 04 Feb 2014 12:52:50 +0100
Message-ID: <52F0D492.9020303@hartkopp.net>
References: <18F8639CFC8C7C4D819AB347808079D4026C69FC@pluto.office.rac.de> <52F0D101.6050500@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:28952 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbaBDLwz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2014 06:52:55 -0500
In-Reply-To: <52F0D101.6050500@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sandro Anders | CarMedialab <sandro.anders@carmedialab.com>, linux-can@vger.kernel.org

ps. You would probably like to have the option '-e' too

On 04.02.2014 12:37, Oliver Hartkopp wrote:
> Hi Sandro,
> 
> did you load the can-gw module?
> 
> When can-gw is not loaded the netlink functions for cangw are not registered.
> 
> Regards,
> Oliver
> 
> On 04.02.2014 11:55, Sandro Anders | CarMedialab wrote:
>> Hi all,
>>
>> I was able to compile the can-utils/* apps without any errors and the
>> most are working. But if I call the cangw command I get the following
>> error message: cangw -A -s can1 -d can3
>> netlink error -95 (Operation not supported)
>>
>> Both CAN's are up and running. My assumption is that there is some
>> netlink support missing in my Kernel, isn't it? Thanks for your help.
>>
>> Sandro 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
