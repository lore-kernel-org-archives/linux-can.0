From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] Join CAN filters with CAN_RAW_JOIN_FILTERS sockopt is ready
 for testing
Date: Wed, 18 Mar 2015 08:13:55 +0100
Message-ID: <550925B3.6010801@hartkopp.net>
References: <550883AF.7080703@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:53695 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbbCRHOE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Mar 2015 03:14:04 -0400
Received: from [192.168.1.194] (p5B0B03B5.dip0.t-ipconnect.de [91.11.3.181])
	by smtp.strato.de (RZmta 37.4 DYNA|AUTH)
	with ESMTPSA id f01538r2I7E2110
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <linux-can@vger.kernel.org>;
	Wed, 18 Mar 2015 08:14:02 +0100 (CET)
In-Reply-To: <550883AF.7080703@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Here some tests with the V2 version:

Current mainline (no modifications)

$ candump vcan0,0:0,0:0
   vcan0  1C8   [8]  5C FE CC 4C E9 4F 4A 21
   vcan0  1C8   [8]  5C FE CC 4C E9 4F 4A 21
   vcan0  60D   [8]  BA 3B 6F 53 05 79 BE 4F
   vcan0  60D   [8]  BA 3B 6F 53 05 79 BE 4F
   vcan0  4BE   [8]  BF AA 6D 72 31 E0 E2 1C
   vcan0  4BE   [8]  BF AA 6D 72 31 E0 E2 1C
   vcan0  7DE   [7]  4A E0 8B 68 AC 6E 0F
   vcan0  7DE   [7]  4A E0 8B 68 AC 6E 0F

two filters for 'all' lead to two frames each.
(cangen vcan0 in separate terminal)

With patch1 (can: fix multiple delivery ...)

$ candump vcan0,0:0,0:0
   vcan0  78D   [8]  C0 71 65 56 23 16 95 6B
   vcan0  70E   [3]  01 D4 CC
   vcan0  749   [7]  A7 8D B3 43 75 C1 22
   vcan0  238   [2]  17 06
   vcan0  108   [4]  8C F7 79 03
   vcan0  190   [0]
   vcan0  25D   [1]  C2
   vcan0  4CE   [4]  6F 1A 50 38

eliminates the double reception.

Now testing patch2 (can: introduce new raw socket option ...)
Using 'cangen vcan0 -I i -n 6 -L 0' in separate terminal.

Current mainline (no modifications)

$ candump vcan0,001~7FF,003~7FF,004~7FF
   vcan0  000   [0]
   vcan0  000   [0]
   vcan0  000   [0]
   vcan0  001   [0]
   vcan0  001   [0]
   vcan0  002   [0]
   vcan0  002   [0]
   vcan0  002   [0]
   vcan0  003   [0]
   vcan0  003   [0]
   vcan0  004   [0]
   vcan0  004   [0]
   vcan0  005   [0]
   vcan0  005   [0]
   vcan0  005   [0]

With patch1 and patch2 but no joined filters:

$ candump vcan0,001~7FF,003~7FF,004~7FF
   vcan0  000   [0]
   vcan0  001   [0]
   vcan0  002   [0]
   vcan0  003   [0]
   vcan0  004   [0]
   vcan0  005   [0]

With patch1 and patch2 with joined filters:

$ candump vcan0,001~7FF,003~7FF,004~7FF,J
   vcan0  000   [0]
   vcan0  002   [0]
   vcan0  005   [0]


Hey - that rocks!


On 17.03.2015 20:42, Oliver Hartkopp wrote:
> Hi all,
>
> as discussed today I posted the patches to "fix the long standing bug" of
> getting duplicate CAN frames when having overlapping filters.
>
> The second patch (and the candump patch) is to test the functionality to
> implement joined filters which provides a logical AND for the given filters.
>
> Happy testing - feedback is welcome!
>
> Regards,
> Oliver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
