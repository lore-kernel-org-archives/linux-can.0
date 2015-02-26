From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb_8dev: Initialisation issue with powered USB 2.0 hub
Date: Thu, 26 Feb 2015 10:41:32 +0100
Message-ID: <54EEEA4C.80009@hartkopp.net>
References: <54D3B071.4040705@hartkopp.net> <54D90ADB.8020700@universalnet.at> <54D90CA7.50302@hartkopp.net> <54DF04A3.1010602@universalnet.at> <54E1900A.4050702@hartkopp.net> <54E22518.6050007@8devices.com> <54E2DD71.1050800@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:17785 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153AbbBZJls (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Feb 2015 04:41:48 -0500
In-Reply-To: <54E2DD71.1050800@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gediminas Simanskis <gediminas@8devices.com>, Bernd Krumboeck <krumboeck@universalnet.at>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Gediminas,

> On 16.02.2015 18:12, Gediminas Simanskis wrote:
>
>> IMHO in main firmware cycle need to check lower USB protocol library states.
>> Currently firmware after descriptor initialization goes to infinite loop and
>> don't check lower USB layer states anymore.

As you already named the potential issue: When do you plan to release a new 
firmware that fixes this warmstart problem?

Regards,
Oliver

