From: Armin Burchardt <armin@uni-bremen.de>
Subject: Re: Standard CAN over IP
Date: Wed, 04 Feb 2015 21:44:36 +0100
Message-ID: <54D284B4.5050501@uni-bremen.de>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gabriel-3.zfn.uni-bremen.de ([134.102.50.3]:36488 "EHLO
	smtp.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964917AbbBDVOM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Feb 2015 16:14:12 -0500
In-Reply-To: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mike Purvis <mpurvis@clearpathrobotics.com>, linux-can@vger.kernel.org

Hi Mike,

On 04.02.2015 21:27, Mike Purvis wrote:
> system as a socketcan can0 device. Is there some standard component
> which already does this, or at least some tooling around serializing
> CAN messages to a bytestream?

there is slcand (UART to socketcan from the can-utils package) to use
serial CAN adapters with socketcan. Implementing the (line based)
protocol in the mcu should not be too hard.

Armin (switching back to read-only mode)

