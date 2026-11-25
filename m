Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.71.1.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614249;
	b=yI8JvXQ8sF0jnrCpa8g84ddkbIWxp/LIyVYsPDN6qI2VAJaXEtafGWW+E+xojaTOSlYq
	 SzxsIU8e87y2tNQHG3Bia2hcArq4LjXgBkAqhbZIPD/TsMHsx1mc9tawGhQwQ6mvxVgEa
	 24CFV+v4/xY67Cub1cVFWDewrtp+/4W7TWtMTk9B50ZNs21yqK/p8B9vKDJcdsrJBM5jQ
	 AeS2kdsCDl73SjGtCiv6ix/0//IQX+8p41dwNJxoONW/mLflYULFmf+d+ehqjdFVDG9H8
	 uCo33xXctLGFKDYh7hbe1seFRcQouRqyeCXY7QATV+4JQw9yeV2xjohjkL6SazXSniQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614249;
	h=DMARC-Filter:Received:X-Barracuda-Envelope-From:
	 X-Barracuda-Effective-Source-IP:X-Barracuda-Apparent-Source-IP:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 X-ASG-Orig-Subj:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Barracuda-Connect:
	 X-Barracuda-Start-Time:X-Barracuda-Encrypted:X-Barracuda-URL:
	 X-Virus-Scanned:X-Barracuda-Scan-Msg-Size:X-ASG-Debug-ID:
	 X-Barracuda-Spam-Score:X-Barracuda-Spam-Status:
	 X-Barracuda-Spam-Report;
	bh=qj3qlAEWyY9IBJU457s/Ux3zGYUrpSNStMSYuv4tkRo=;
	b=Nqk6jR+T6s5JwjkGvRHNn9DMa7kssIbW60cEhw2zlhmvcWTgepk1xMtfMcofuGOuCgDc
	 DxcfwwE+VfMAM816ktTrohUC4MPv4S+1vDuOInrWd/pxEgxwGdOTvdO0J/LIl7lUauJ75
	 zD/RE77K/GkOI+5Savehn1/yHjRXiOTLVtiLfut7/8h4gvFsVffn3arAB8rcl7AO2JZsV
	 N5v6x1LJJuvx/drTEYacrmcdHsp7urdKlGDLsC9zgRVqNnFmMXEmjmucFsyJcfBW3M51L
	 vEPnxM+o8sfHBs7at53a4dGqAW97nHMVHk+lLfhSJLFKDYEY+kQLl2hfwJblPdL5dqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vandijck-laurijssen.be;
	spf=pass smtp.mailfrom=vandijck-laurijssen.be;
	dkim=pass header.d=vandijck-laurijssen.be header.i=@vandijck-laurijssen.be header.a=rsa-sha256 header.s=default header.b=UheX4ecq;
	arc=none smtp.remote-ip=212.71.1.222
Received: from relay-b02.edpnet.be (relay-b02.edpnet.be [212.71.1.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7F7606A321
	for <linux-can@vger.kernel.org>; Wed, 25 Nov 2026 13:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF7F7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vandijck-laurijssen.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vandijck-laurijssen.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vandijck-laurijssen.be header.i=@vandijck-laurijssen.be header.a=rsa-sha256 header.s=default header.b=UheX4ecq
Received: from srv21.vandijck-laurijssen.be ([213.219.153.140]) by relay-b02.edpnet.be with ESMTP id AgiBz5o9SnwFiOA8 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO); Wed, 25 Nov 2026 14:44:00 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[213.219.153.140]
X-Barracuda-Apparent-Source-IP: 213.219.153.140
Received: from fwg.vandijck-laurijssen.be (fwg.vandijck-laurijssen.be [IPv6:fd01::dab3:2fff:febd:d001])
	by srv21.vandijck-laurijssen.be (Postfix) with ESMTPSA id 33083B389CD;
	Wed, 25 Nov 2026 14:44:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=vandijck-laurijssen.be; s=default; t=1795614240;
	bh=qj3qlAEWyY9IBJU457s/Ux3zGYUrpSNStMSYuv4tkRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UheX4ecq0duA2RB5l0GOqgtOxGqtKBuhKfa5fgjPUizdB8ti3XxcOVU4oEpG/vrG5
	 +g6HoCJGgUoTBXQleKEHvNu5Khy0g2WRa16ouTaCQrZbOlHFWqN+939028+o1cmaQh
	 OpLyOb1HrFEF2TeHWbpmjfkuFo6yEhvxxWprVfsJ7ub+kKbbp+jvtx9C29aIvJCQsx
	 KFYpE2AZhgohOwzRDHzCDZLaEHtdXG5lcIkYi2TRTMGhgScW3HBqfYjsDulI/jMINt
	 ICuvAH5GjnxaRkePLOB6wVOLXJn7VgX43BKb0c0ZGCrZdcSYYpxWuhslYL6rQoIPsn
	 R9L5Ml5jmpbKA==
Date: Wed, 25 Nov 2026 14:43:58 +0100
From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-can@vger.kernel.org, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net-next 10/12] can: remove Softing CANcard driver
Message-ID: <awbmHl75TSW4fc1K@fwg.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH net-next 10/12] can: remove Softing CANcard driver
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
	netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-can@vger.kernel.org, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>
References: <20261118092955.1283165-1-mkl@pengutronix.de>
 <20261118092955.1283165-11-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261118092955.1283165-11-mkl@pengutronix.de>
X-Barracuda-Connect: UNKNOWN[213.219.153.140]
X-Barracuda-Start-Time: 1795614240
X-Barracuda-Encrypted: TLS_AES_256_GCM_SHA384
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 60
X-ASG-Debug-ID: 1795614240-214fdf6fb6350990001-ZXuqFv
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	

Acked-By: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
