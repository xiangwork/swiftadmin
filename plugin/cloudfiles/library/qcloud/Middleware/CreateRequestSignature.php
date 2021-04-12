<?php

namespace Overtrue\CosClient\Middleware;

use Overtrue\CosClient\Signature;
use Psr\Http\Message\RequestInterface;

class CreateRequestSignature
{
    protected $secretId;

    protected $secretKey;

    protected $signatureExpires;

    /**
     * WithSignature constructor.
     *
     * @param  string  $secretId
     * @param  string  $secretKey
     * @param  string|null  $signatureExpires
     */
    public function __construct(string $secretId, string $secretKey, ?string $signatureExpires = null)
    {
        $this->secretId = $secretId;
        $this->secretKey = $secretKey;
        $this->signatureExpires = $signatureExpires;
    }

    public function __invoke(callable $handler)
    {
        return function (RequestInterface $request, array $options) use ($handler) {
            $request = $request->withHeader(
                'Authorization',
                (new Signature($this->secretId, $this->secretKey))
                    ->createAuthorizationHeader($request, $this->signatureExpires)
            );

            return $handler($request, $options);
        };
    }
}
