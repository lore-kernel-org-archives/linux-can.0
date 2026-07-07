Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629427466A
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403932; cv=none; b=VNTBvjdNyAqbO2MtRojL1exfzhUoiiym3OU2/inupwJdL0mY/SO1se9hY1gZxjmfdgIw7O1Kl04nBWaV8FGT2qyGwQ/qSPgGrbWhs73bbJ3eZwjD1FeBMODDrsJjNG7VyDLPDPWBJpJHXehU/+Zi8vvyzrV2KD3RhqMFCzMIyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403932; c=relaxed/simple;
	bh=iqidT9IDQi3JPjoHd2ejPJaUNZLao120O8mmi/giSnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2NaoGxOh+Q3kBm86RBjBl3Suen8Y6wwrZ3J3PJfbMSNlHqEe22EDRy2ymjzO0+LxT/NDy5ntmpkl67Tz+BI8nVEwsA0d4MOdir+0OXOJmN0ldHnLdAeSXTh2zdRT0S9d1kQMRnswCWWzB6kfDAcHhfxEGZDZfGSfgytP4OEL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LizRrqQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LizRrqQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5861F000E9;
	Tue,  7 Jul 2026 05:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783403930;
	bh=2SjRVV0YM5ftwKXtXC/stGCA7doFGhrJJerQzxnzOCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LizRrqQkCS1MB4zZcsvzLNfImS9/k8Z0v1Q853/8aIvqh8W5c2zQBWAGfdYe43x3c
	 5bMoJcSH1zKBOaQAhCsFbEjvQdC8q6EVDEgGmh4y5NQi7MWlxKKkbdv/VwhngSPB3G
	 TWhU6st/nkB4A/f+z3O3kit2Kaf+Y0weZjYCssuY=
Date: Tue, 7 Jul 2026 07:59:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Dynetrex, Admin" <admin@dynetrex.com>
Cc: linux-can@vger.kernel.org, peter_hong@fintek.com.tw, mkl@pengutronix.de,
	mailhol@kernel.org, stable@kernel.org
Subject: Re: [REGRESSION] can: usb: f81604: TX broken with "short int URB: 9
 < 12"
Message-ID: <2026070732-reformer-civil-a4d8@gregkh>
References: <A3834A07-5639-4779-844F-C5843DFC3928@dynetrex.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A3834A07-5639-4779-844F-C5843DFC3928@dynetrex.com>

On Mon, Jul 06, 2026 at 10:46:00PM -0700, Dynetrex, Admin wrote:
> Hello,
> 
> I found an issue with a patch applied to the can/usb/f81604 driver on 2026-02-23.
> 
> https://git.kernel.org/stable/c/36ead57443146e6b730ce1f48ca3e9b17e19a3d2
> 
> The patch added a check to make sure urb->actual_length is not less than sizeof(struct f81604_int_data). The issue is that the interrupt data from the device is 9 bytes, but sizeof(struct f81604_int_data) returns 12 because the struct is marked __aligned(4).
> 
> This causes valid interrupt URBs to be rejected. After this patch, CAN frames no longer transmit successfully, while before the patch they transmitted without issue.
> 
> Each transmit attempt logs the following in dmesg:
> 
> f81604_read_int_callback: short int URB: 9 < 12
> 
> Please consider either removing the __aligned(4) attribute from struct f81604_int_data, or using a constant for the actual wire packet length when checking urb->actual_length.

Please consider submitting a patch to resolve this issue so you get full
credit for the fix.

thanks,

greg k-h
