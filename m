Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ED4C2D0E4
	for <linux-can@archiver.kernel.org>; Tue, 17 Nov 2020 11:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707A52222E
	for <linux-can@archiver.kernel.org>; Tue, 17 Nov 2020 11:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgKQLgg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-can@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:36:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:13664 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgKQLgg (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 17 Nov 2020 06:36:36 -0500
IronPort-SDR: YVawogSooEHZjG3gVDUOuUpBI/Q7EV/W2vuI4hoa+L6XaT1uRFMlWMNOjSTPbzdEqupYclvYZf
 U1d1jvAXcL9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="235055376"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="235055376"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 03:36:35 -0800
IronPort-SDR: 5H8ibe/Eas8Hn9yBRDalvTQdNMH7/KA/GKfPbH0uDr/nrHOCiKGv6TAWwxED/IIwcdNOw/4zRV
 QA38yupT70jw==
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="325128604"
Received: from amwebb-mobl2.ger.corp.intel.com (HELO pflykt-mobl1.ger.corp.intel.com) ([10.252.19.117])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 03:36:33 -0800
Received: by pflykt-mobl1.ger.corp.intel.com (Postfix, from userid 1100)
        id 9D56A3200D5; Tue, 17 Nov 2020 13:36:30 +0200 (EET)
Message-ID: <3b81ac4f9f845627a1f2f9170c1a76b60366797b.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/1] NET: mcan: Move runtime PM enable/disable to
 m_can_platform
From:   Patrik Flykt <patrik.flykt@linux.intel.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de, dmurphy@ti.com,
        sriram.dash@samsung.com, jarkko.nikula@intel.com
Date:   Tue, 17 Nov 2020 13:36:30 +0200
In-Reply-To: <20201023115800.46538-2-patrik.flykt@linux.intel.com>
References: <20201023115800.46538-1-patrik.flykt@linux.intel.com>
         <20201023115800.46538-2-patrik.flykt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 2020-10-23 at 14:58 +0300, Patrik Flykt wrote:
> This is a preparatory patch for upcoming PCI based M_CAN devices.
> The current PM implementation would cause PCI based drivers to
> enable PM twice, once when the PCI device is added and a second
> time in m_can_class_register(). This will cause 'Unbalanced
> pm_runtime_enable!' to be logged, and is a situation that should
> be avoided.
> 
> Therefore, in anticipation of PCI devices, move PM enabling out
> from M_CAN class registration to its only user, the
> m_can_platform driver.
> 
> Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> ---
> v2: Rebased on mkl/linux-can.git 9146843b11b6

Ping ping?

	Patrik


