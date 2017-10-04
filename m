From: <Marcel.Birthelmer@microchip.com>
Subject: MCP2517FD Bus-Off recovery
Date: Wed, 4 Oct 2017 16:32:04 +0000
Message-ID: <883AF5B5924A484BBBA6684EAC878AEAC573DF@CHN-SV-EXMX02.mchp-main.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7766 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdJDQcG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2017 12:32:06 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,
I'm working on a driver for the new MCP2517FD CAN controller (http://www.microchip.com/wwwproducts/en/MCP2517FD). This is a substantially different device from the MCP2515 so it's a separate driver.

My question pertains to error recovery. This device automatically recovers from Bus-Off to Error-Active after some internal delay (see fig.11-1 of the Family Reference Manual). The ISR detects this state change, but I'm not sure how to handle it in regards to can_restart. Should I just update call netif_carrier_on and netif_wake_queue from the ISR to put the device back into normal mode?

Also, should the CAN state really be set to CAN_STATE_BUS_OFF while the device is in bus-off mode, since it will recover automatically and there's no explicit "restart" action?

Thanks,
- Marcel
