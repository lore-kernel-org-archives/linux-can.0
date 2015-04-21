From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Vector .blf file format
Date: Tue, 21 Apr 2015 14:13:21 +0200
Message-ID: <55363EE1.9010100@hartkopp.net>
References: <20150421102419.GC27504@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:34304 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbbDUMNj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Apr 2015 08:13:39 -0400
In-Reply-To: <20150421102419.GC27504@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org

Hi Kurt,

I'm usually using CANalyser to convert the BLF Logfiles to create some .asc 
output to feed it into asc2log.

I just took a look on the Vector website:
Obviously you can download some CANalyser demo version which is *not* able to 
access real CAN hardware. But you don't need real hardware :-)

So you might have luck to be able to use the logfile conversion functionality.

https://vector.com/vi_downloadcenter_en.html?product=canalyzer&busprot=CANBUS&formular_treffer_submit=1

Regards,
Oliver


On 21.04.2015 12:24, Kurt Van Dijck wrote:
> Hi all,
>
> This is strictly speaking not a linux-can question.
>
> I received, from a customer, CAN logs
> as Vector's binary .blf (binary log file?) format.
>
> Does anyone know how to parse, besides buying the CANalyzer software?
>
> Kind regards,
> Kurt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
