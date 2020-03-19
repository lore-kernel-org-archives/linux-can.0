From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: PCI/PCIe cards and MSI support
Date: Thu, 19 Mar 2020 15:01:27 +0100
Message-ID: <20200319140127.GD2538@x1.vandijck-laurijssen.be>
References: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:34748 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgCSOVN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Mar 2020 10:21:13 -0400
Content-Disposition: inline
In-Reply-To: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hey,

> or if the driver can decide to request (resp. free) IRQs when loading (resp. unloading)
> the module?

This seems a bad idea. Loading the module should not allocate resources.
A reasonable point IMHO is the probe of a device.

Kurt
