Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E5EEB64D7
	for <linux-can@archiver.kernel.org>; Tue, 20 Jun 2023 13:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjFTNN7 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjFTNN6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Jun 2023 09:13:58 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A287B4
        for <linux-can@vger.kernel.org>; Tue, 20 Jun 2023 06:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687266834; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=O4Ls5NnyeTl5wZxMynYwF93HiK1Pv3sLRH5ZucdtZFlRcbX0oq3Nf47CZDxwIyfviI
    xD6leQzMz+8iOqBMNlqejuXWJC/pztR7ichNwsywDFZ+/Oq8egCTdMVADa/dmfTWlLVF
    NJBKOZPHUlVilfhVGkd5BW7zbMgCX9JHP0HLbaJlqyKAunNH6xcFIcAvr/DgY6oLuE+I
    pBNmDqP4NSS1rIg5RZNd2RW4PeyzgpjcBG6f5wR1SIV2L22z2lkDMhYfbpUNic05AUnD
    U/zowXnIivMzIM/EQD97ero7hPifx2aQhJXWyjYtN2EgiEmqzyVlcRh38p7tme8m2v+9
    AApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687266834;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8X1JG20kolLTdO+1CxlfBJFapuTGWestDlWCXcJBzSc=;
    b=JUpYmU8IjBIc3Myp2xcX4CRPDDt9KzEMHtkuSeV/oSgw/x+WeRnrWMlZbk0Z8SCmqJ
    XFQOL1rExSzgFBL5O1iBOREShvWkN8+8QFgI2oihmREsc3zBehrafLAb2tNUFbdNQEny
    klwSQuMxYvp+rYhqPlztXOaS79amgPBmIf/2t03EorfDUTbbvh89OSO43hmMuDNygHXq
    K3OfgRqtjyAH/suKiM1U86RHx0WZ238kwNIgXTbyjVXGSClch/2+aAyJkNGNwpmdDVqu
    ENpuNl+GjVmqqWySSVYUv3CdvVex8VaUfo7wVnl0VfYfGpCyTv/5vqudVri2JUgAFgQd
    KzOQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687266834;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8X1JG20kolLTdO+1CxlfBJFapuTGWestDlWCXcJBzSc=;
    b=lQd52kjDSqVyt/mpQHBO7el+q0z4RPjK6z1d2QJrD0GiC8FGwYLAfYK01iIbMSUEg2
    HwBEupM81Eb8H83jr+azfBTzBHlfaL6hS3oxR8knUeJXlbDIgYqQmhhIEzCU6POMZMBv
    EzikuwYMXIBSjVtVdofArD1dgG1MTB5UAEgAJFNFvIQeFqAbCtcGBrYUJUDhWGdmxM82
    5kJNRJxPRAMb2YcIQUwYPExEd4fssjJT0TgGEFWYzjb8WGSStlF0Zqd9bk1dtg58DtWX
    a1kyRhH1z4mqOeYRtHvT8fZOcelmSiLOjeglgwK4vQ2s8RS42A1fXTn7ma51xYTg/Jx2
    ItBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687266834;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8X1JG20kolLTdO+1CxlfBJFapuTGWestDlWCXcJBzSc=;
    b=aBnFRPiYnrpys3tFDt1wPBWZk0s1ujpsswgMkNlZNeEy/GsarIy3yt4s/kF2HBkWlg
    trCXyUSzziKz+FWVg2Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id J16f43z5KDDsGhU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 20 Jun 2023 15:13:54 +0200 (CEST)
Message-ID: <9d003714-263f-6562-d099-53007fbde53c@hartkopp.net>
Date:   Tue, 20 Jun 2023 15:13:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/2] can: fix coding style
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20230620131130.240180-1-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230620131130.240180-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 20.06.23 15:11, Marc Kleine-Budde wrote:
> Hello,
> 
> here are 2 coding style fixes for the rx-offload and ti_hecc.
> 
> Changes since v1:
> - removed Fixes tag

Thanks Marc!

Best regards,
Oliver
