From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Bug] Kernel Panic on Deletion of the network-namespace
 containing the SocketCAN interface
Date: Thu, 16 Jul 2020 20:37:38 +0200
Message-ID: <88fb5401-746a-5589-650d-a88fde43b122@hartkopp.net>
References: <20ea6d4c00dc4d5f99cd004677280369@hs-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:36761 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgGPSku (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Jul 2020 14:40:50 -0400
In-Reply-To: <20ea6d4c00dc4d5f99cd004677280369@hs-karlsruhe.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Philipp Lehmann <leph1016@hs-karlsruhe.de>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "christian.sauer.w@sew-eurodrive.de" <christian.sauer.w@sew-eurodrive.de>

Hi Philipp,

thanks for the report and its reproducer!

I assumed the interfaces - at least in the case of 'real' hardware CAN 
interfaces - to me moved back to the root name space ... well.

I'll take a look at it.

Best regards,
Oliver

On 16.07.20 18:46, Philipp Lehmann wrote:
> If a SocketCAN Interface (Tested with a PCAN-USB adapter) is moved into a network-namespace and the network namespace is deleted afterwards, without moving the device out of the namespace prior to the deletion. The device could not be found in any of the network namespaces afterwards, only a reboot of the system fixes this. If the device is instead removed from the USB-Bus without a restart, a kernel panic is the result.
> 
> 
> Output of uname -r [Linux cpc4x 5.4.0-40-generic #44-Ubuntu SMP Tue Jun 23 00:01:04 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux]
> 
> 
> The bug could be reproduced with the following steps:
> 
> 
> 1. Connect the (USB)-SocketCAN device to the host
> 
> 2. Add a new network namespace [sudo ip netns add test]
> 3. Move the CAN-interface to the network name-space [sudo ip link set dev can0 netns test]
> 4. Delete the namespace [sudo ip netns delete test]
> 5. Remove the adapter from the USB-Bus. In most cases this should result in a kernel panic
> 
