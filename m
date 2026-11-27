Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.163
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780734;
	b=BjGpBr1KcsyR75lc7umvz0tQk5Ms425GIi6JP1cpp3kw/CfvgCE07FBXn4ZkKBb5qpKn
	 piaL0SWriQbx4n7w7UVz+CgwTWyaXlEXg/kAfols+JdiYp5VDdxTGd8RVv+4tmL1fo8Ky
	 xHjt/sMuyfJ85mLOwX2PlVWTVQhL0y+DsGKbkcbBjNM43m8lR2p0ZL3fIawSfNPn1p/I4
	 pLtPphSrFsaGvoEXPtcuV3/qil7NvuUqVdnEbN0/oyuYCXzWf6MWroxuXfEI+ZdLNO+Hr
	 hfYFikhN78DJU/V6GUVWiKEodK5iWrM4UZfrp254tkppb8Qj1YJ2u/0076OPji0V2fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780734;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZCUcpxHroGYyt5Yej2gqU4LjGQoCpUJTHrJ8Q7o1X4c=;
	b=Yv5JEQnzEkWtlC8KSSQqL/fpBpwQaypDbFjc79Qr+zaWDIbqXl1tTH2wn74PNoNsYlah
	 WFBtsnDyo2CQclXMq7Wt0FlRjfTi4jtF61UwlyDMTJgKfkfNJtsL3uH1lcP9C0D+jI0Sx
	 4fhDqFjc+a6eBmb55ZaC9SNO9RI+G9tfLOHu1PU9BByg9edVX3V/+8efZRNNcwm7PbmRJ
	 82tkuqAjbZLrxtCnVi0irmwa7EZrCsycJUQ5iaFKFfcG/HdIeVMEpmpBqa99yNv6gN9H6
	 I7rTHKRbn8ym9jGuU9kkIJ1lYBw32eNB4zTB7eHXUv73hP2K9IF+n4Q3wMERXOXhWTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Go05xRkF;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mPdZYik8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.163
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E3606A327
	for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 11:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 102E3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Go05xRkF;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mPdZYik8
ARC-Seal: i=1; a=rsa-sha256; t=1795780725; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=g5Sh2bTgRnP363stJBD1uPamND4SsDWKuYZi/mFZeqUWavgjuGo43WEPr+sxDIpV33
    VsuXkjTXjvFUJiS5ULT9jNvuQKZcOG4c9TekoshaVBcQH/6y6BqThnZarD7bk3pMyI53
    WAqQ43iTlkJo4O/5IZHm0IoM71r5x3sg0yPLZjoSNMd/SL44EXKqhbMnTHq9zlIcrwmI
    PWvplLeDCsT5TONbaaOFk5bkMNc644d4ti1uckw/KfyMOpg9idHfPiiKSi3hW+JuCuJL
    EuwsNgZKGHf9bwmDk+f3r8w6PLXmXW3e+gfIFU/ZHx7dC0JhYqSlnXezjkhucAyu/Iaw
    CiDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795780725;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZCUcpxHroGYyt5Yej2gqU4LjGQoCpUJTHrJ8Q7o1X4c=;
    b=CXZNMCayhH5jBrQTjC3HSbXeJxzCvs0TODCJiG/GtAYol4AAdJSJbDm90wh6BOdrnc
    MtEFw+oIg/mi9Oq2MIjU9Fll69CDlO25QTNn5hID1vsioDUEMn+hxEIh3tDeXyKu28fd
    HouNbT9lYRDOXUQF84JSO0yaM2H96/PsY6obIMN7W6GCZ7FWOrOWjMvpkMz4yFQbwWw7
    zqlm9Rw7qsaIinPyuyS/fLX2aI6ORB5ki3WapOpOQ/rujgB13nphTojOwNiRz2lk3Kek
    L1BlwUtMfc4GSnIDKMezMuiGXcfrGiFsvGzqnKsp6UdU10iAarrCFqeYKfVnP1C+uWU8
    h5wA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795780725;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZCUcpxHroGYyt5Yej2gqU4LjGQoCpUJTHrJ8Q7o1X4c=;
    b=Go05xRkFaoilUwFiMt4UjMWZjbdXUBu4ovTr0BBGmkdoZCDd9k4UPzQlK1NbldCmA0
    aYX8o5YBCnBvONJGMNKFfcLio4kMJn4AJgAAkS5ds4ogvVvdZ8cDHvXDTEGvAbIaLqX+
    FtYyhP58jdfONZ8Yjl3c7os3dzL+VMOVXJKalpqx5f2rGZr783SWwFILww9NyJuZeD5t
    moOMNwTLxBaq0yiVs1U34haLCEJXHHEg0Q0+x2Tp3Idq41XVijdTS6xOTne/9MvXPvYC
    ZuiNDg+M7ohjLiU3OrIlo1mKWvA+LXcxPzLGl+S5pQVW46p46DGi979JXt2VeA+Zhy3Z
    fT+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795780724;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZCUcpxHroGYyt5Yej2gqU4LjGQoCpUJTHrJ8Q7o1X4c=;
    b=mPdZYik82Hu/37bXoaQ0VeFGf+mMbDOcM7gd5kCE+l6JNNRPaZ/fBU3BuOUGLj6COF
    lCagsl7iGthw26PvagAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ARBwiwpF
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 27 Nov 2026 12:58:44 +0100 (CET)
Message-ID: <6fdfe8ce-69cf-410b-9edb-1ce318d4b02e@hartkopp.net>
Date: Fri, 27 Nov 2026 12:58:39 +0100
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next 03/22] can: enable memcg accounting for user
 triggered allocations
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
 <20261126-getsockopt-memcg-isotp-v1-3-681ef8d8c2c9@hartkopp.net>
 <d65925ac-364d-4fa6-adce-dfa4027ef509@hartkopp.net>
 <awluhW_a2C7mJa2b@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <awluhW_a2C7mJa2b@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.11.26 12:50, Oleksij Rempel wrote:

> On Fri, Nov 27, 2026 at 11:08:17AM +0100, Oliver Hartkopp wrote:
>> Would it make sense to split this patch into a J1939 and a non-J1939
>> part and to post the J1939 memcg accounting when all J1939 fixes have
>> hit the mainline tree?
> 
> Thank you for thinking about it. As far as I can see, there is no need
> to split it. The J1939 part only touches the j1939_priv allocation and
> the SO_J1939_FILTER copy, and the pending J1939 fixes I know of do not
> touch these lines. If a conflict shows up later, it should be easy to
> resolve.
> 
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 

Great! Thanks!

So let's see what Sashiko has to grumble whether I need to re-spin ;-)

Best regards,
Oliver
