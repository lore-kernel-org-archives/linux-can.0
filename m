From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Can bus simulator
Date: Wed, 13 Apr 2016 09:14:40 +0200
Message-ID: <570DF1E0.7090504@hartkopp.net>
References: <86DFA4E2-8971-48B1-852D-82DFAFA957DF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:36105 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362AbcDMHO4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Apr 2016 03:14:56 -0400
In-Reply-To: <86DFA4E2-8971-48B1-852D-82DFAFA957DF@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kay Cee <unee0x@gmail.com>
Cc: linux-can@vger.kernel.org

You can use the virtual CAN interfaces, see

	https://www.kernel.org/doc/Documentation/networking/can.txt

Chapter 6.4

Regards,
Oliver

On 04/13/2016 08:17 AM, kay Cee wrote:
> Is there a way to test a canbus tester without actual can signals?
>
> I have a can bus testing station but no can signals readily available..
>
> Sent from my iPhone
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
